#
# Cookbook Name:: tomcat
# Attributes:: default
#
# Copyright 2010-2015, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
case node['platform']
when "centos", "redhat", "oracle"
  default['tomcat']['base_version'] = 8
when "debian", "ubuntu"
  default['tomcat']['base_version'] = 7
else
  default['tomcat']['base_version'] = 6
end

default['tomcat']['access_log_pattern'] = 'common'
default['tomcat']['base_instance'] = "tomcat#{node['tomcat']['base_version']}"
default['tomcat']['port'] = 8080
default['tomcat']['proxy_port'] = nil
default['tomcat']['proxy_name'] = nil
default['tomcat']['secure'] = nil
default['tomcat']['scheme'] = nil
default['tomcat']['ssl_port'] = 8443
default['tomcat']['ssl_proxy_port'] = nil
default['tomcat']['ajp_port'] = 8009
default['tomcat']['ajp_redirect_port'] = nil
default['tomcat']['ajp_listen_ip'] = nil
default['tomcat']['shutdown_port'] = 8005
default['tomcat']['catalina_options'] = ''
default['tomcat']['java_options'] = '-Xmx128M -Djava.awt.headless=true -XX:+UseConcMarkSweepGC'
default['tomcat']['use_security_manager'] = false
default['tomcat']['authbind'] = 'no'
default['tomcat']['deploy_manager_apps'] = true
default['tomcat']['max_threads'] = nil
default['tomcat']['generate_ssl_cert'] = true
default['tomcat']['ssl_max_threads'] = 150
default['tomcat']['ssl_cert_file'] = nil
default['tomcat']['ssl_key_file'] = nil
default['tomcat']['redirect_http_to_https'] = false
default['tomcat']['ssl_chain_files'] = []
default['tomcat']['ssl_enabled_protocols'] = nil
default['tomcat']['ciphers'] = nil
default['tomcat']['keystore_file'] = 'keystore.jks'
default['tomcat']['keystore_type'] = 'jks'
# The keystore and truststore passwords will be generated by the
# openssl cookbook's secure_password method in the recipe if they are
# not otherwise set. Do not hardcode passwords in the cookbook.
# default['tomcat']["keystore_password'] = nil
# default['tomcat']["truststore_password'] = nil
default['tomcat']['install_method'] = node['tomcat']['base_version'] == 8 ? 'archive' : 'package'
default['tomcat']['archive_url'] = "https://s3.amazonaws.com/boundlessps-public/apache-tomcat-7.0.67.tar.gz" if node['tomcat']['base_version'] == 7
default['tomcat']['archive_url'] = "https://s3.amazonaws.com/boundlessps-public/apache-tomcat-8.0.32.tar.gz" if node['tomcat']['base_version'] == 8
default['tomcat']['deploy_default_webapps'] = true
default['tomcat']['truststore_file'] = nil
default['tomcat']['truststore_type'] = 'jks'
default['tomcat']['certificate_dn'] = 'cn=localhost'
default['tomcat']['loglevel'] = 'INFO'
default['tomcat']['tomcat_auth'] = 'true'
default['tomcat']['client_auth'] = 'false'
default['tomcat']['instances'] = {}
default['tomcat']['run_base_instance'] = true
default['tomcat']['environment'] = []
default['tomcat']['packages'] = ["tomcat#{node['tomcat']['base_version']}"]
default['tomcat']['deploy_manager_packages'] = ["tomcat#{node['tomcat']['base_version']}-admin"]
default['tomcat']['ajp_packetsize'] = '8192'
default['tomcat']['uriencoding'] = 'UTF-8'
default['tomcat']['jndi'] = false
default['tomcat']['jndi_connections'] = []
default['tomcat']['cors_enabled'] = false
default['tomcat']['ldap_enabled'] = false
default['tomcat']['ldap_servers'] = []
default['tomcat']['ldap_port'] = 389
default['tomcat']['ldap_bind_user'] = nil
default['tomcat']['ldap_bind_pwd'] = nil
default['tomcat']['ldap_user_base'] = nil
default['tomcat']['ldap_role_base'] = nil
default['tomcat']['ldap_group'] = nil
default['tomcat']['ldap_domain_name'] = nil
default['tomcat']['ldap_user_search'] = "(sAMAccountName={0})"
default['tomcat']['ldap_role_search'] = "(member={0})"
case node['platform_family']
when 'rhel'
  if node.platform_version.to_i == 6
    default['tomcat']['base_instance'] = "tomcat#{node['tomcat']['base_version']}"
    default['tomcat']['user'] = 'tomcat'
    default['tomcat']['group'] = 'tomcat'
    default['tomcat']['home'] = "/usr/share/tomcat#{node['tomcat']['base_version']}"
    default['tomcat']['base'] = "/usr/share/tomcat#{node['tomcat']['base_version']}"
    default['tomcat']['config_dir'] = "/etc/tomcat#{node['tomcat']['base_version']}"
    default['tomcat']['log_dir'] = "/var/log/tomcat#{node['tomcat']['base_version']}"
    default['tomcat']['tmp_dir'] = "/var/cache/tomcat#{node['tomcat']['base_version']}/temp"
    default['tomcat']['work_dir'] = "/var/cache/tomcat#{node['tomcat']['base_version']}/work"
    default['tomcat']['context_dir'] = "#{node["tomcat"]["config_dir"]}/Catalina/localhost"
    default['tomcat']['webapp_dir'] = "#{node["tomcat"]["home"]}/webapps"
    default['tomcat']['keytool'] = 'keytool'
    default['tomcat']['lib_dir'] = "#{node["tomcat"]["home"]}/lib"
    default['tomcat']['endorsed_dir'] = "#{node["tomcat"]["lib_dir"]}/endorsed"
    default['tomcat']['packages'] = ["tomcat#{node['tomcat']['base_version']}"]
    default['tomcat']['deploy_manager_packages'] = ["tomcat#{node['tomcat']['base_version']}-admin-webapps"]
    default['tomcat']['app_base'] = "webapps"
  elsif node.platform_version.to_i == 7
    if node['tomcat']['install_method'] == "package"
      default['tomcat']['base_instance'] = "tomcat"
      default['tomcat']['home'] = "/usr/share/tomcat"
      default['tomcat']['config_dir'] = "/etc/tomcat"
      default['tomcat']['log_dir'] = "/var/log/tomcat"
      default['tomcat']['tmp_dir'] = "/var/cache/tomcat/temp"
      default['tomcat']['work_dir'] = "/var/cache/tomcat/work"
      default['tomcat']['webapp_dir'] = "/var/lib/tomcat/webapps"
    elsif node['tomcat']['install_method'] == "archive"
      default['tomcat']['base_instance'] = "tomcat#{node['tomcat']['base_version']}"
      default['tomcat']['home'] = "/usr/share/tomcat#{node['tomcat']['base_version']}"
      default['tomcat']['config_dir'] = "/etc/tomcat#{node['tomcat']['base_version']}"
      default['tomcat']['log_dir'] = "/var/log/tomcat#{node['tomcat']['base_version']}"
      default['tomcat']['tmp_dir'] = "/var/cache/tomcat#{node['tomcat']['base_version']}/temp"
      default['tomcat']['work_dir'] = "/var/cache/tomcat#{node['tomcat']['base_version']}/work"
      default['tomcat']['webapp_dir'] = "#{node["tomcat"]["home"]}/webapps"
    end
    default['tomcat']['base'] = node['tomcat']['home']
    default['tomcat']['user'] = 'tomcat'
    default['tomcat']['group'] = 'tomcat'
    default['tomcat']['keytool'] = 'keytool'
    default['tomcat']['lib_dir'] = "#{node["tomcat"]["home"]}/lib"
    default['tomcat']['context_dir'] = "#{node["tomcat"]["config_dir"]}/Catalina/localhost"
    default['tomcat']['endorsed_dir'] = "#{node["tomcat"]["lib_dir"]}/endorsed"
    default['tomcat']['packages'] = ["tomcat"]
    default['tomcat']['deploy_manager_packages'] = ["tomcat-admin-webapps"]
    default['tomcat']['app_base'] = "webapps"
  end
when 'fedora'
  suffix = node['tomcat']['base_version'].to_i < 7 ? node['tomcat']['base_version'] : ''

  default['tomcat']['base_instance'] = "tomcat#{suffix}"
  default['tomcat']['user'] = 'tomcat'
  default['tomcat']['group'] = 'tomcat'
  default['tomcat']['home'] = "/usr/share/tomcat#{suffix}"
  default['tomcat']['base'] = "/usr/share/tomcat#{suffix}"
  default['tomcat']['config_dir'] = "/etc/tomcat#{suffix}"
  default['tomcat']['log_dir'] = "/var/log/tomcat#{suffix}"
  default['tomcat']['tmp_dir'] = "/var/cache/tomcat#{suffix}/temp"
  default['tomcat']['work_dir'] = "/var/cache/tomcat#{suffix}/work"
  default['tomcat']['context_dir'] = "#{node['tomcat']['config_dir']}/Catalina/localhost"
  default['tomcat']['webapp_dir'] = "/var/lib/tomcat#{suffix}/webapps"
  default['tomcat']['keytool'] = 'keytool'
  default['tomcat']['lib_dir'] = "#{node['tomcat']['home']}/lib"
  default['tomcat']['endorsed_dir'] = "#{node['tomcat']['lib_dir']}/endorsed"
  default['tomcat']['packages'] = ["tomcat#{suffix}"]
  default['tomcat']['deploy_manager_packages'] = ["tomcat#{suffix}-admin-webapps"]
  default['tomcat']['app_base'] = "webapps"
when 'debian'
  default['tomcat']['user'] = "tomcat#{node['tomcat']['base_version']}"
  default['tomcat']['group'] = "tomcat#{node['tomcat']['base_version']}"
  default['tomcat']['home'] = "/usr/share/tomcat#{node['tomcat']['base_version']}"
  default['tomcat']['base'] = "/var/lib/tomcat#{node['tomcat']['base_version']}"
  default['tomcat']['config_dir'] = "/etc/tomcat#{node['tomcat']['base_version']}"
  default['tomcat']['log_dir'] = "/var/log/tomcat#{node['tomcat']['base_version']}"
  default['tomcat']['tmp_dir'] = "/tmp/tomcat#{node['tomcat']['base_version']}-tmp"
  default['tomcat']['work_dir'] = "/var/cache/tomcat#{node['tomcat']['base_version']}"
  default['tomcat']['context_dir'] = "#{node['tomcat']['config_dir']}/Catalina/localhost"
  default['tomcat']['webapp_dir'] = "/var/lib/tomcat#{node['tomcat']['base_version']}/webapps"
  default['tomcat']['app_base'] = "webapps"
  default['tomcat']['keytool'] = 'keytool'
  default['tomcat']['lib_dir'] = "#{node['tomcat']['home']}/lib"
  default['tomcat']['endorsed_dir'] = "#{node['tomcat']['lib_dir']}/endorsed"
when 'smartos'
  default['tomcat']['user'] = 'tomcat'
  default['tomcat']['group'] = 'tomcat'
  default['tomcat']['home'] = '/opt/local/share/tomcat'
  default['tomcat']['base'] = '/opt/local/share/tomcat'
  default['tomcat']['config_dir'] = '/opt/local/share/tomcat/conf'
  default['tomcat']['log_dir'] = '/opt/local/share/tomcat/logs'
  default['tomcat']['tmp_dir'] = '/opt/local/share/tomcat/temp'
  default['tomcat']['work_dir'] = '/opt/local/share/tomcat/work'
  default['tomcat']['context_dir'] = "#{node['tomcat']['config_dir']}/Catalina/localhost"
  default['tomcat']['webapp_dir'] = '/opt/local/share/tomcat/webapps'
  default['tomcat']['app_base'] = "webapps"
  default['tomcat']['keytool'] = '/opt/local/bin/keytool'
  default['tomcat']['lib_dir'] = "#{node['tomcat']['home']}/lib"
  default['tomcat']['endorsed_dir'] = "#{node['tomcat']['home']}/lib/endorsed"
  default['tomcat']['packages'] = ['apache-tomcat']
  default['tomcat']['deploy_manager_packages'] = []
when 'suse'
  default['tomcat']['base_instance'] = 'tomcat'
  default['tomcat']['user'] = 'tomcat'
  default['tomcat']['group'] = 'tomcat'
  default['tomcat']['home'] = '/usr/share/tomcat'
  default['tomcat']['base'] = '/usr/share/tomcat'
  default['tomcat']['config_dir'] = '/etc/tomcat'
  default['tomcat']['log_dir'] = '/var/log/tomcat'
  default['tomcat']['tmp_dir'] = '/var/cache/tomcat/temp'
  default['tomcat']['work_dir'] = '/var/cache/tomcat/work'
  default['tomcat']['context_dir'] = "#{node['tomcat']['config_dir']}/Catalina/localhost"
  default['tomcat']['webapp_dir'] = '/srv/tomcat/webapps'
  default['tomcat']['keytool'] = 'keytool'
  default['tomcat']['lib_dir'] = "#{node['tomcat']['home']}/lib"
  default['tomcat']['endorsed_dir'] = "#{node['tomcat']['lib_dir']}/endorsed"
  default['tomcat']['packages'] = ['tomcat']
  default['tomcat']['deploy_manager_packages'] = ['tomcat-admin-webapps']
when 'windows'
  default['tomcat']['install_method'] = 'archive'
  default['tomcat']['base_instance'] = "tomcat#{node.tomcat.base_version}"
  default['tomcat']['base'] = "C:\\bin\\tomcat\\#{node.tomcat.base_version}"
  default['tomcat']['home'] = node['tomcat']['base']
  default['tomcat']['config_dir'] = "#{node.tomcat.home}\\conf"
  default['tomcat']['service']['name'] = "tomcat#{node.tomcat.base_version}"
  default['tomcat']['webapp_dir'] = "#{node.tomcat.home}\\webapps"
  default['tomcat']['log_dir'] = "#{node.tomcat.home}\\logs"
  default['tomcat']['tmp_dir'] = "#{node.tomcat.home}\\temp"
  default['tomcat']['work_dir'] = "#{node.tomcat.home}\\work"
  default['tomcat']['context_dir'] = "#{node.tomcat.config_dir}\\Catalina\\localhost"
  default['tomcat']['lib_dir'] = "#{node.tomcat.home}/lib"
  default['tomcat']['endorsed_dir'] = "#{node.tomcat.lib_dir}/endorsed"
  default['tomcat']['app_base'] = "webapps"
  default['tomcat']['generate_ssl_cert'] = false
  default['tomcat']['service']['display_name'] = "Apache Tomcat 7.0 Tomcat7 (remove only)"
  default['tomcat']['packages'] = []
  if node['tomcat']['base_version'] == 7
    default['tomcat']['version'] = "apache-tomcat-7.0.62"
    default['tomcat']['archive_url'] = "https://s3.amazonaws.com/cap-public/apache-tomcat-7.0.62-windows-x64.zip"
  elsif node['tomcat']['base_version'] == 8
    default['tomcat']['version'] = "apache-tomcat-8.0.23"
    default['tomcat']['archive_url'] = "https://s3.amazonaws.com/cap-public/apache-tomcat-8.0.23-windows-x64.zip"
  end
else
  default['tomcat']['user'] = "tomcat#{node['tomcat']['base_version']}"
  default['tomcat']['group'] = "tomcat#{node['tomcat']['base_version']}"
  default['tomcat']['home'] = "/usr/share/tomcat#{node['tomcat']['base_version']}"
  default['tomcat']['base'] = "/var/lib/tomcat#{node['tomcat']['base_version']}"
  default['tomcat']['config_dir'] = "/etc/tomcat#{node['tomcat']['base_version']}"
  default['tomcat']['log_dir'] = "/var/log/tomcat#{node['tomcat']['base_version']}"
  default['tomcat']['tmp_dir'] = "/tmp/tomcat#{node['tomcat']['base_version']}-tmp"
  default['tomcat']['work_dir'] = "/var/cache/tomcat#{node['tomcat']['base_version']}"
  default['tomcat']['context_dir'] = "#{node['tomcat']['config_dir']}/Catalina/localhost"
  default['tomcat']['webapp_dir'] = "/var/lib/tomcat#{node['tomcat']['base_version']}/webapps"
  default['tomcat']['app_base'] = "webapps"
  default['tomcat']['keytool'] = 'keytool'
  default['tomcat']['lib_dir'] = "#{node['tomcat']['home']}/lib"
  default['tomcat']['endorsed_dir'] = "#{node['tomcat']['lib_dir']}/endorsed"
end
