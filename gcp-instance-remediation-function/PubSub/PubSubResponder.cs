using CloudNative.CloudEvents;
using GCPFunctionsX.Utilities;
using Google.Cloud.Functions.Framework;
using Google.Events.Protobuf.Cloud.PubSub.V1;
using Newtonsoft.Json.Linq;
using System;
using System.IO;
using System.Text.RegularExpressions;
using System.Threading;
using System.Threading.Tasks;

namespace GCPFunctionsX
{
    public class PubSubResponder : ICloudEventFunction<MessagePublishedData>
    {
        public async Task HandleAsync(CloudEvent cloudEvent, MessagePublishedData data, CancellationToken cancellationToken)
        {
            Console.WriteLine("Message published data:");
            Console.WriteLine($"  Message: {data.Message}");
            Console.WriteLine($"  Message.TextData: {data.Message.TextData}");
            Console.WriteLine("Cloud event information:");
            Console.WriteLine($"  ID: {cloudEvent.Id}");
            Console.WriteLine($"  Source: {cloudEvent.Source}");
            Console.WriteLine($"  Type: {cloudEvent.Type}");
            Console.WriteLine($"  Subject: {cloudEvent.Subject}");
            Console.WriteLine($"  DataSchema: {cloudEvent.DataSchema}");
            Console.WriteLine($"  DataContentType: {cloudEvent.DataContentType}");
            Console.WriteLine($"  Time: {cloudEvent.Time?.ToUniversalTime():yyyy-MM-dd'T'HH:mm:ss.fff'Z'}");
            Console.WriteLine($"  SpecVersion: {cloudEvent.SpecVersion}");

            // TODO: we should handle the type of input via the service name + method name properties


            // parse
            var jObj = JObject.Parse(data.Message.TextData);
            var methodName = jObj.SelectToken("$.protoPayload.methodName").Value<string>();
            var instanceSelfLink = jObj.SelectToken("$.protoPayload.resourceName").Value<string>();

            switch(methodName)
            {
                // EVENT: Insert a Compute Instance
                case "v1.compute.instances.insert":
                case "beta.compute.instances.insert":
                    // create instance from compute engine > instances > create

                    var instanceName = Path.GetFileName(instanceSelfLink);

                    var res = Regex.Match(instanceSelfLink, "projects/(.+)/zones/(.+)/instances/(.+)");
                    var input = res.Groups[0];
                    var projectId = res.Groups[1];
                    var zone = res.Groups[2];
                    var instance = res.Groups[3];

                    if (instance.ToString().Contains("instance"))
                    {
                        var cs = new ComputeEngineService();
                        cs.DeleteInstance(projectId.ToString(), instance.ToString(), zone.ToString());
                    }
                    break;

                // EVENT: List Service Account Keys
                case "google.iam.admin.v1.ListServiceAccountKeys":
                    var email = jObj.SelectToken("$.protoPayload.authenticationInfo.principalEmail").Value<string>();
                    break;

                // EVENT: SET IAM POLICY
                case "google.iam.admin.v1.SetIAMPolicy":
                    var e = jObj.SelectToken("$.protoPayload.authenticationInfo.principalEmail").Value<string>();
                    var deltas = jObj.SelectToken("$.protoPayload.response").Value<string>();
                    break;

                default:
                    break;
            }
        }
    }
}
