Set( $rtname, $ENV{RT_NAME} || "example.com" );
Set( $Organisation, $ENV{Organisation} || "example.com" );
Set( $WebDomain, $ENV{WEB_DOMAIN} || "localhost" );
Set( $WebPort, $ENV{WEB_PORT} || 80 );
Set( $LogToSTDERR, $ENV{LOG_LEVEL} || "info" );
Set( $Timezone, $ENV{RT_TZ} || "UTC" );
Set( $EmailOutputEncoding, "utf-8" );
Set( $OwnerEmail, $ENV{OWNER_EMAIL} || "owner@example.com" );
Set( $CanonicalizeRedirectURLs, $ENV{BEHIND_REVERSE_PROXY} || 0 );

if ($ENV{RT_MAIL_FROM}) {
    Set( $SetOutgoingMailFrom, $ENV{RT_MAIL_FROM})
}

Set( $DatabaseType, "Pg" );
Set( $DatabaseHost, $ENV{DATABASE_HOST} || $ENV{DB_PORT_5432_TCP_ADDR} || "localhost" );
Set( $DatabasePort, $ENV{DATABASE_PORT} || "" );
Set( $DatabaseName, $ENV{DATABASE_NAME} || "rt4" );
Set( $DatabaseUser, $ENV{DATABASE_USER} || "rt_user" );
Set( $DatabasePassword, $ENV{DATABASE_PASSWORD} || "rt_pass" );

# GnuPG support
Set( %GnuPG, Enable => $ENV{GPG_ENABLE} || 0 );

if ($ENV{GPG_ENABLE} {
    Set(%GnuPGOptions,
        homedir           => '/opt/rt4/var/gpg',
        default-key       => $ENV{GPG_DEFAULT_KEY},
        passphrase        => $ENV{GPG_PASSPHRASE},
        keyserver         => $ENV{GPG_KEYSERVER} || 'hkp://pgp.mit.edu',
        keyserver-options => 'auto-key-retrive',
    );
    Set(@MailPlugins, 'Auth::MailFrom', 'Auth::Crypt' );
}

# Load plugins

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
