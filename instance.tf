    module "ec2" {
  source        = "clouddrove/ec2/aws"

    name        = "ec2"
    environment = "test"
    label_order = ["name", "environment"]

    #instance
    instance_enabled = true
    instance_count   = 2
    ami              = "ami-08d658f84a6d84a80"
    instance_type    = "t2.nano"
    monitoring       = false
    tenancy          = "default"

    #Networking
    vpc_security_group_ids_list = [module.ssh.security_group_ids, module.http-https.security_group_ids]
    subnet_ids                  = tolist(module.public_subnets.public_subnet_id)
    assign_eip_address          = true
    associate_public_ip_address = true

    #Keypair
    key_name = module.keypair.name

    #IAM
    instance_profile_enabled = true
    iam_instance_profile     = module.iam-role.name

    #Root Volume
    root_block_device = [
      {
        volume_type           = "gp2"
        volume_size           = 15
        delete_on_termination = true
        kms_key_id            = module.kms_key.key_arn
      }
    ]

    #EBS Volume
    ebs_optimized      = false
    ebs_volume_enabled = false
    ebs_volume_type    = "gp2"
    ebs_volume_size    = 30

    #DNS
    dns_enabled = false
    dns_zone_id = "Z1XJD7SSBKXLC1"
    hostname    = "ec2"

    #Tags
    instance_tags = { "snapshot" = true }

    # Metadata
    metadata_http_tokens_required        = "optional"
    metadata_http_endpoint_enabled       = "enabled"
    metadata_http_put_response_hop_limit = 2
    }
