using Google.Apis.Auth.OAuth2;
using Google.Apis.Compute.v1;
using Google.Apis.Services;
using Newtonsoft.Json;
using System;
using System.Threading.Tasks;

namespace GCPFunctionsX.Utilities
{
    public class ComputeEngineService
    {
        public void DeleteInstance(string projectId, string instance, string zone)
        {
            ComputeService computeService = new ComputeService(new BaseClientService.Initializer
            {
                HttpClientInitializer = GetCredential(),
                ApplicationName = "Google-ComputeSample/0.1",
            });

            InstancesResource.DeleteRequest request = computeService.Instances.Delete(projectId, zone, instance);
            
            // To execute asynchronously in an async method, replace `request.Execute()` as shown:
            var response = request.Execute();
            // Data.Operation response = await request.ExecuteAsync();

            // TODO: Change code below to process the `response` object:
            Console.WriteLine(JsonConvert.SerializeObject(response));
        }

        public static GoogleCredential GetCredential()
        {
            GoogleCredential credential = Task.Run(() => GoogleCredential.GetApplicationDefaultAsync()).Result;
            if (credential.IsCreateScopedRequired)
            {
                credential = credential.CreateScoped("https://www.googleapis.com/auth/cloud-platform");
            }
            return credential;
        }
    }
}