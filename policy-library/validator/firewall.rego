#
# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

package templates.gcp.GCPFirewallConstraintV1

deny[{
	"msg": message,
	"details": metadata,
}] {
	constraint := input.constraint
	asset := input.asset
	asset.asset_type == "compute.googleapis.com/Firewall"

	asset.resource.discovery_name == "Firewall"

	# IF INGRESS THEN?
	asset.resource.data.direction == "INGRESS"

	# then PRIORITY MUST BE GREATER THAN 0 and LESS THAN 1001
	asset.resource.data.priority > 0
	asset.resource.data.priority < 1001

	re_match("^allow-.\\w*", asset.resource.data.name)

	pattern := "^allow-.\\w*"
	output := regex.split(pattern, asset.resource.data.name)
	sprintf("%v asdfasdfasdf-asdfasdf", [asset.name])

	# 
	#asset.resource.data.name == "allow-ssh"

	message := sprintf("%v meets firewall specifications", [asset.name])
	metadata := {"resource": asset.name}
}
