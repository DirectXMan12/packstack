$trove_rab_cfg_trove_db_pw = hiera('CONFIG_TROVE_DB_PW')
$trove_rab_cfg_mariadb_host = hiera('CONFIG_MARIADB_HOST')
$trove_rab_cfg_controller_host = hiera('CONFIG_CONTROLLER_HOST')

class {'trove':
    rpc_backend                  => 'trove.openstack.common.rpc.impl_kombu',
    rabbit_host                  => hiera('CONFIG_AMQP_HOST'),
    rabbit_port                  => hiera('CONFIG_AMQP_CLIENTS_PORT'),
    rabbit_userid                => hiera('CONFIG_AMQP_AUTH_USER'),
    rabbit_password              => hiera('CONFIG_AMQP_AUTH_PASSWORD'),
    database_connection          => "mysql://trove:${trove_rab_cfg_trove_db_pw}@${trove_rab_cfg_mariadb_host}/trove",

    nova_proxy_admin_user        => hiera('CONFIG_TROVE_NOVA_USER'),
    nova_proxy_admin_tenant_name => hiera('CONFIG_TROVE_NOVA_TENANT'),
    nova_proxy_admin_pass        => hiera('CONFIG_TROVE_NOVA_PW'),
    # NB(sross): for some reason, keystone isn't sending the service
    #            catalog to Trove, so we specify these manually
    nova_compute_url             => "http://${trove_rab_cfg_controller_host}:8774/v2",
    cinder_url                   => "http://${trove_rab_cfg_controller_host}:8776/v1",
    swift_url                    => "http://${trove_rab_cfg_controller_host}:8080/v1/AUTH_"
}
