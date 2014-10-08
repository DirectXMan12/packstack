
class { 'trove::keystone::auth':
    region           => hiera('CONFIG_KEYSTONE_REGION'),
    password         => hiera('CONFIG_TROVE_KS_PW'),
    public_address   => hiera('CONFIG_TROVE_HOST'),
    admin_address    => hiera('CONFIG_TROVE_HOST'),
    internal_address => hiera('CONFIG_TROVE_HOST'),
}
