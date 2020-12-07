package Cx

CxPolicy [ result ] {
   document := input.document
   resources := input.document[i].Resources[name]
   check_security_groups_ingress(resources.Properties)
   
      result := {
                "documentId": 		input.document[i].id,
                "searchKey":      sprintf("Resources.%s.Properties", [name]),
                "issueType":		   "IncorrectValue",
                "keyExpectedValue": sprintf("None of the Resources.%s.Properties.SecurityGroupIngress has 0.0.0.0/0", [name]),
                "keyActualValue": 	sprintf("One of the Resources.%s.Properties.SecurityGroupIngress has 0.0.0.0/0", [name])
              }
}

CxPolicy [ result ] {
   document := input.document
   resources := input.document[i].Resources[name]
   check_security_groups_egress(resources.Properties)
   
      result := {
                "documentId": 		input.document[i].id,
                "searchKey":      sprintf("Resources.%s.Properties", [name]),
                "issueType":		   "IncorrectValue",
                "keyExpectedValue": sprintf("None of the Resources.%s.Properties.SecurityGroupEgress has 0.0.0.0/0", [name]),
                "keyActualValue": 	sprintf("One of the Resources.%s.Properties.SecurityGroupEgress has 0.0.0.0/0", [name])
              }
}

check_security_groups_ingress(group) {
	group.SecurityGroupIngress[_].CidrIp == "0.0.0.0/0"
}

check_security_groups_egress(group) {
	group.SecurityGroupEgress[_].CidrIp == "0.0.0.0/0"
}