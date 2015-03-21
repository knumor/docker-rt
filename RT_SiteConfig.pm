Set( $rtname, $ENV{RT_NAME} || "example.com" );
Set( $Organisation, $ENV{Organisation} || "example.com" );
Set( $WebDomain, $ENV{WEB_DOMAIN} || "localhost" );
Set( $WebPort, $ENV{WEB_PORT} || 80 );
Set( $LogToSTDERR, $ENV{LOG_LEVEL} || "info" );
Set( $Timezone, "UTC" );

Set( $DatabaseType, "Pg" );
Set( $DatabaseHost, $ENV{DATABASE_HOST} || $ENV{DB_PORT_5432_TCP_ADDR} || "localhost" );
Set( $DatabasePort, $ENV{DATABASE_PORT} || "" );
Set( $DatabaseName, $ENV{DATABASE_NAME} || "rt4" );
Set( $DatabaseUser, $ENV{DATABASE_USER} || "rt_user" );
Set( $DatabasePassword, $ENV{DATABASE_PASSWORD} || "rt_pass" );

# GnuPG support requires extra work downstream to enable
Set( %GnuPG, Enable => 0 );

Plugin( "RT::Extension::ResetPassword" );
Plugin( "RT::Extension::MergeUsers" );

### xtraplugins ###


# Enable full text search
if ($ENV{USE_FTS}) {
    Set( %FullTextSearch,
        Enable     => 1,
        Indexed    => 1,
        Column     => 'ContentIndex',
        Table      => 'Attachments',
    );
}

Set( @Active_MakeClicky, qw(httpurl_overwrite short_ticket_link) );

1;
