{
	"contents": {
		"26b2e790-c575-4670-8c0e-76931cb4fd2f": {
			"classDefinition": "com.sap.bpm.wfs.Model",
			"id": "approveuser",
			"subject": "Please Approve New User ",
			"name": "ApproveUser",
			"documentation": "Approve New User",
			"lastIds": "0305ed9a-423b-4c4d-9a2a-3ff4b800182e",
			"events": {
				"52432dda-5403-42ef-97db-43372ea25459": {
					"name": "Start Event"
				},
				"e672c1f3-6550-420c-adb1-1689954de16e": {
					"name": "EndEvent1"
				}
			},
			"activities": {
				"b51c5c27-526b-45bb-bd89-59ad5e76962d": {
					"name": "UI for Approval"
				},
				"bc99e42f-bc53-4baa-ab4e-41a3701573e5": {
					"name": "Prepare for Rules"
				},
				"2869bf6a-6323-47c5-8856-e0fa23abf18b": {
					"name": "Invoke Rules"
				},
				"51f8313b-ee7d-4198-a57b-e9383137ed25": {
					"name": "Process Rules Output"
				}
			},
			"sequenceFlows": {
				"e1710839-5237-4831-b592-129d05d5499e": {
					"name": "SequenceFlow3"
				},
				"5ab620e0-1ece-418b-b54d-2e1432b092b0": {
					"name": "SequenceFlow10"
				},
				"230fc9d9-b6b6-45aa-bee7-58d22fa78799": {
					"name": "SequenceFlow11"
				},
				"87ac3060-12e4-408d-9801-45703b8be0ad": {
					"name": "SequenceFlow12"
				},
				"069dc3da-7cb7-4c41-94e9-390f4ee58894": {
					"name": "SequenceFlow13"
				}
			},
			"diagrams": {
				"48bfa0c8-6bd4-4edd-a796-570f584b4ec2": {}
			}
		},
		"52432dda-5403-42ef-97db-43372ea25459": {
			"classDefinition": "com.sap.bpm.wfs.StartEvent",
			"id": "startevent1",
			"name": "Start Event"
		},
		"e672c1f3-6550-420c-adb1-1689954de16e": {
			"classDefinition": "com.sap.bpm.wfs.EndEvent",
			"id": "endevent1",
			"name": "EndEvent1"
		},
		"b51c5c27-526b-45bb-bd89-59ad5e76962d": {
			"classDefinition": "com.sap.bpm.wfs.UserTask",
			"subject": "Approve new user request for ${context.userData.firstname}",
			"description": "User creation request from Company ${context.organization}",
			"isHiddenInLogForParticipant": false,
			"userInterface": "sapui5://html5apps/mywfapp/webapp/approval/approval",
			"recipientUsers": "${context.approver}",
			"id": "usertask1",
			"name": "UI for Approval",
			"documentation": "Approve Users"
		},
		"bc99e42f-bc53-4baa-ab4e-41a3701573e5": {
			"classDefinition": "com.sap.bpm.wfs.ScriptTask",
			"script": "//Retreive organization name from email domain\nvar email = $.context.userData.email;\nvar domain = email.replace(/.*@/, \"\");\nvar orgName = domain.substring(0, domain.lastIndexOf(\".\"));\n\n//Prepare the payload to invoke the Rule service\n$.context.userData.input.__type__= \"User\";\n$.context.userData.input.organization = orgName;\n\n",
			"id": "scripttask2",
			"name": "Prepare for Rules"
		},
		"2869bf6a-6323-47c5-8856-e0fa23abf18b": {
			"classDefinition": "com.sap.bpm.wfs.ServiceTask",
			"destination": "Rules",
			"path": "/invoke?rule_service_name=selfregistration::selfregistration",
			"httpMethod": "POST",
			"xsrfPath": "/xsrf-token",
			"requestVariable": "${context.userData.input}",
			"responseVariable": "${context.userData.output}",
			"id": "servicetask1",
			"name": "Invoke Rules"
		},
		"51f8313b-ee7d-4198-a57b-e9383137ed25": {
			"classDefinition": "com.sap.bpm.wfs.ScriptTask",
			"script": "\n//Store organization name in a context variable \n$.context.organization = $.context.userData.input.organization;\n\n//Convert to Uppercase as the user name in recipient is case sensitive\nvar approve = $.context.userData.output.approver;\n$.context.approver = approve.toUpperCase();\n",
			"id": "scripttask4",
			"name": "Process Rules Output"
		},
		"e1710839-5237-4831-b592-129d05d5499e": {
			"classDefinition": "com.sap.bpm.wfs.SequenceFlow",
			"id": "sequenceflow3",
			"name": "SequenceFlow3",
			"sourceRef": "52432dda-5403-42ef-97db-43372ea25459",
			"targetRef": "bc99e42f-bc53-4baa-ab4e-41a3701573e5"
		},
		"5ab620e0-1ece-418b-b54d-2e1432b092b0": {
			"classDefinition": "com.sap.bpm.wfs.SequenceFlow",
			"id": "sequenceflow10",
			"name": "SequenceFlow10",
			"sourceRef": "bc99e42f-bc53-4baa-ab4e-41a3701573e5",
			"targetRef": "2869bf6a-6323-47c5-8856-e0fa23abf18b"
		},
		"230fc9d9-b6b6-45aa-bee7-58d22fa78799": {
			"classDefinition": "com.sap.bpm.wfs.SequenceFlow",
			"id": "sequenceflow11",
			"name": "SequenceFlow11",
			"sourceRef": "2869bf6a-6323-47c5-8856-e0fa23abf18b",
			"targetRef": "51f8313b-ee7d-4198-a57b-e9383137ed25"
		},
		"87ac3060-12e4-408d-9801-45703b8be0ad": {
			"classDefinition": "com.sap.bpm.wfs.SequenceFlow",
			"id": "sequenceflow12",
			"name": "SequenceFlow12",
			"sourceRef": "b51c5c27-526b-45bb-bd89-59ad5e76962d",
			"targetRef": "e672c1f3-6550-420c-adb1-1689954de16e"
		},
		"069dc3da-7cb7-4c41-94e9-390f4ee58894": {
			"classDefinition": "com.sap.bpm.wfs.SequenceFlow",
			"id": "sequenceflow13",
			"name": "SequenceFlow13",
			"sourceRef": "51f8313b-ee7d-4198-a57b-e9383137ed25",
			"targetRef": "b51c5c27-526b-45bb-bd89-59ad5e76962d"
		},
		"48bfa0c8-6bd4-4edd-a796-570f584b4ec2": {
			"classDefinition": "com.sap.bpm.wfs.ui.Diagram",
			"symbols": {
				"fb80214e-569c-4bd4-8d48-629c37b19c1c": {},
				"5a6fca7d-645f-4bbf-95a1-aa685fee415b": {},
				"86621b1c-1f57-4a98-88bd-30d344262ce3": {},
				"dd8e0e4d-56a5-4091-98c7-66dbc6040791": {},
				"440656b6-9728-4f96-9d9e-2d88bc7e26af": {},
				"c89cca3e-f650-4535-84b1-bcd7ec359286": {},
				"7cd04af0-e4ae-45ac-bc4f-c24b2f1cf473": {},
				"84d83535-3048-422e-acc8-d096f1f1466d": {},
				"c6fe3e99-28d6-4cbb-b32f-b1128bc4ac63": {},
				"0969e5c2-3b8e-478c-9cc5-e926d57a66b3": {},
				"2bdf8016-8b90-480e-8c74-4307900549d5": {}
			}
		},
		"fb80214e-569c-4bd4-8d48-629c37b19c1c": {
			"classDefinition": "com.sap.bpm.wfs.ui.StartEventSymbol",
			"x": 30,
			"y": 104,
			"width": 32,
			"height": 32,
			"object": "52432dda-5403-42ef-97db-43372ea25459"
		},
		"5a6fca7d-645f-4bbf-95a1-aa685fee415b": {
			"classDefinition": "com.sap.bpm.wfs.ui.EndEventSymbol",
			"x": 783,
			"y": 98,
			"width": 32,
			"height": 32,
			"object": "e672c1f3-6550-420c-adb1-1689954de16e"
		},
		"86621b1c-1f57-4a98-88bd-30d344262ce3": {
			"classDefinition": "com.sap.bpm.wfs.ui.UserTaskSymbol",
			"x": 609,
			"y": 92.5,
			"width": 100,
			"height": 55,
			"object": "b51c5c27-526b-45bb-bd89-59ad5e76962d"
		},
		"dd8e0e4d-56a5-4091-98c7-66dbc6040791": {
			"classDefinition": "com.sap.bpm.wfs.ui.SequenceFlowSymbol",
			"points": "46,120 177,120",
			"sourceSymbol": "fb80214e-569c-4bd4-8d48-629c37b19c1c",
			"targetSymbol": "440656b6-9728-4f96-9d9e-2d88bc7e26af",
			"object": "e1710839-5237-4831-b592-129d05d5499e"
		},
		"440656b6-9728-4f96-9d9e-2d88bc7e26af": {
			"classDefinition": "com.sap.bpm.wfs.ui.ScriptTaskSymbol",
			"x": 127,
			"y": 92.5,
			"width": 100,
			"height": 55,
			"object": "bc99e42f-bc53-4baa-ab4e-41a3701573e5"
		},
		"c89cca3e-f650-4535-84b1-bcd7ec359286": {
			"classDefinition": "com.sap.bpm.wfs.ui.ServiceTaskSymbol",
			"x": 292,
			"y": 92.5,
			"width": 100,
			"height": 55,
			"object": "2869bf6a-6323-47c5-8856-e0fa23abf18b"
		},
		"7cd04af0-e4ae-45ac-bc4f-c24b2f1cf473": {
			"classDefinition": "com.sap.bpm.wfs.ui.SequenceFlowSymbol",
			"points": "177,120 328,120",
			"sourceSymbol": "440656b6-9728-4f96-9d9e-2d88bc7e26af",
			"targetSymbol": "c89cca3e-f650-4535-84b1-bcd7ec359286",
			"object": "5ab620e0-1ece-418b-b54d-2e1432b092b0"
		},
		"84d83535-3048-422e-acc8-d096f1f1466d": {
			"classDefinition": "com.sap.bpm.wfs.ui.SequenceFlowSymbol",
			"points": "342,120 496,120",
			"sourceSymbol": "c89cca3e-f650-4535-84b1-bcd7ec359286",
			"targetSymbol": "0969e5c2-3b8e-478c-9cc5-e926d57a66b3",
			"object": "230fc9d9-b6b6-45aa-bee7-58d22fa78799"
		},
		"c6fe3e99-28d6-4cbb-b32f-b1128bc4ac63": {
			"classDefinition": "com.sap.bpm.wfs.ui.SequenceFlowSymbol",
			"points": "659,120.5 811,120.5",
			"sourceSymbol": "86621b1c-1f57-4a98-88bd-30d344262ce3",
			"targetSymbol": "5a6fca7d-645f-4bbf-95a1-aa685fee415b",
			"object": "87ac3060-12e4-408d-9801-45703b8be0ad"
		},
		"0969e5c2-3b8e-478c-9cc5-e926d57a66b3": {
			"classDefinition": "com.sap.bpm.wfs.ui.ScriptTaskSymbol",
			"x": 446,
			"y": 92.5,
			"width": 100,
			"height": 55,
			"object": "51f8313b-ee7d-4198-a57b-e9383137ed25"
		},
		"2bdf8016-8b90-480e-8c74-4307900549d5": {
			"classDefinition": "com.sap.bpm.wfs.ui.SequenceFlowSymbol",
			"points": "496,120 659,120",
			"sourceSymbol": "0969e5c2-3b8e-478c-9cc5-e926d57a66b3",
			"targetSymbol": "86621b1c-1f57-4a98-88bd-30d344262ce3",
			"object": "069dc3da-7cb7-4c41-94e9-390f4ee58894"
		},
		"0305ed9a-423b-4c4d-9a2a-3ff4b800182e": {
			"classDefinition": "com.sap.bpm.wfs.LastIDs",
			"sequenceflow": 13,
			"startevent": 1,
			"endevent": 1,
			"servicetask": 2,
			"usertask": 1,
			"scripttask": 4
		}
	}
}