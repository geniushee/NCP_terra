terraform {
  required_providers {
    ncloud = {
      source = "NaverCloudPlatform/ncloud"
    }
  }
  required_version = ">= 0.13"
}

resource "ncloud_login_key" "loginkey" {
  key_name = "${var.login_key_name}-4321"
}

resource "ncloud_server" "server" {
  name = "${var.server_group}-1"
  server_image_product_code = "SPSW0LINUX000139"
  server_product_code = "SPSVRSTAND000077"
  login_key_name = ncloud_login_key.loginkey.key_name

  tag_list {
    tag_key = "testkey1"
    tag_value = "testvalue1"
  }

  access_control_group_configuration_no_list = [1494885]

}

resource "local_file" "ncp_pem" {
  filename = "${ncloud_login_key.loginkey.key_name}.pem"
  content = ncloud_login_key.loginkey.private_key
}

data "ncloud_root_password" "default"{
  server_instance_no = ncloud_server.server.instance_no
  private_key = ncloud_login_key.loginkey.private_key
}

resource "local_file" "key"{
  filename = "${ncloud_server.server.name}-key.txt"
  content = "${ncloud_server.server.name} => ${data.ncloud_root_password.default.root_password}"
}
