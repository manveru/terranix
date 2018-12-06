{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.cloudflare;

in {

  options.cloudflare.provider = {
    email = mkOption {
      type    = with types; string;
      description = ''
         The email associated with the account. This can also be specified with the CLOUDFLARE_EMAIL shell environment variable.
      '';
    };
    token = mkOption {
      type    = with types; string;
      description = ''
        The Cloudflare API token. This can also be specified with the CLOUDFLARE_TOKEN shell environment variable.
      '';
    };
    rps = mkOption {
      type    = with types; nullOr int;
      default = null;
      description = ''
        RPS limit to apply when making calls to the API.
        This can also be specified with the CLOUDFLARE_RPS shell environment variable.
      '';
    };
    retries = mkOption {
      type    = with types; nullOr string;
      default = null;
      description = ''
        Maximum number of retries to perform when an API request fails.
        This can also be specified with the CLOUDFLARE_RETRIES shell environment variable.
      '';
    };
    min_backoff = mkOption {
      type    = with types; nullOr int;
      default = null;
      description = ''
        Minimum backoff period in seconds after failed API calls.
        This can also be specified with the CLOUDFLARE_MIN_BACKOFF shell environment variable.
      '';
    };
    max_backoff = mkOption {
      type    = with types; nullOr int;
      default = null;
      description = ''
        Maximum backoff period in seconds after failed API calls
        This can also be specified with the CLOUDFLARE_MAX_BACKOFF shell environment variable.
      '';
    };
    api_client_logging = mkOption {
      type    = with types; nullOr bool;
      default = null;
      description = ''
        Whether to print logs from the API client (using the default log library logger).
        This can also be specified with the CLOUDFLARE_API_CLIENT_LOGGING shell environment variable.
      '';
    };
    org_id = mkOption {
      type    = with types; nullOr string;
      default = null;
      description = ''
        Configure API client with this organisation ID, so calls use the organization API rather
        than the (default) user API. This is required for other users in your organization to have
        access to the resources you manage. This can also be specified with the CLOUDFLARE_ORG_ID
        shell environment variable.
      '';
    };
    use_org_from_zone = mkOption {
      type    = with types; nullOr string;
      default = null;
      description = ''
        Takes a zone name value. This is used to lookup the organization ID that owns this zone,
        which will be used to configure the API client. If org_id is also specified, this field will
        be ignored. This can also be specified with the CLOUDFLARE_ORG_ZONE shell environment variable.
      '';
    };
  };

  config = mkIf cfg.enable {
    provider.cloudflare = {
      email = cfg.provider.email;
      token = cfg.provider.token;
      rps = cfg.provider.rps;
      retries  = cfg.provider.retries;
      min_backoff  = cfg.provider.min_backoff;
      max_backoff = cfg.provider.max_backoff;
      api_client_logging  = cfg.provider.api_client_logging;
      org_id  = cfg.provider.org_id;
      use_org_from_zone  = cfg.provider.use_org_from_zone;
    };
  };
}
