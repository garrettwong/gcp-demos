using Google.Apis.Auth.OAuth2;
using System.Threading.Tasks;

namespace GCPFunctionsX.Utilities
{
    public interface ITokenService
    {
        Task<string> GetBearerToken(string audience);
    }

    public class TokenService : ITokenService
    {
        public async Task<string> GetBearerToken(string audience)
        {
            // get bearer token
            var oidcToken = await GoogleCredential
                .GetApplicationDefault()
                .GetOidcTokenAsync(OidcTokenOptions.FromTargetAudience(audience));
            var token = await oidcToken.GetAccessTokenAsync();
            return token;
        }
    }
}
