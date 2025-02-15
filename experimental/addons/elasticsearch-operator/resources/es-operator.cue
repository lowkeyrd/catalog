package main

esOperator: {
	type: "k8s-objects"
	name: "elasticsearch-operator"
	properties: {
		objects: [
			{
				"apiVersion": "v1"
				"kind":       "ServiceAccount"
				"metadata": {
					"name":      "elastic-operator"
					"namespace": parameter.namespace
					"labels": {
						"control-plane":             "elastic-operator"
						"app.kubernetes.io/version": "2.6.1"
					}
				}
			},
			{
				"apiVersion": "v1"
				"kind":       "Secret"
				"metadata": {
					"name":      "elastic-webhook-server-cert"
					"namespace": parameter.namespace
					"labels": {
						"control-plane":             "elastic-operator"
						"app.kubernetes.io/version": "2.6.1"
					}
				}
			},
			{
				"apiVersion": "v1"
				"kind":       "ConfigMap"
				"metadata": {
					"name":      "elastic-operator"
					"namespace": parameter.namespace
					"labels": {
						"control-plane":             "elastic-operator"
						"app.kubernetes.io/version": "2.6.1"
					}
				}
				"data": {
					"eck.yaml": "log-verbosity: 0\nmetrics-port: 0\ncontainer-registry: docker.elastic.co\ncontainer-suffix: \nmax-concurrent-reconciles: 3\nca-cert-validity: 8760h\nca-cert-rotate-before: 24h\ncert-validity: 8760h\ncert-rotate-before: 24h\nexposed-node-labels: [topology.kubernetes.io/.*,failure-domain.beta.kubernetes.io/.*]\nset-default-security-context: auto-detect\nkube-client-timeout: 60s\nelasticsearch-client-timeout: 180s\ndisable-telemetry: false\ndistribution-channel: all-in-one\nvalidate-storage-class: true\nenable-webhook: true\nwebhook-name: elastic-webhook.k8s.elastic.co\nenable-leader-election: true\nelasticsearch-observation-interval: 10s"
				}
			},
			{
				"apiVersion": "rbac.authorization.k8s.io/v1"
				"kind":       "ClusterRole"
				"metadata": {
					"name": "elastic-operator"
					"labels": {
						"control-plane":             "elastic-operator"
						"app.kubernetes.io/version": "2.6.1"
					}
				}
				"rules": [
					{
						"apiGroups": [
							"authorization.k8s.io",
						]
						"resources": [
							"subjectaccessreviews",
						]
						"verbs": [
							"create",
						]
					},
					{
						"apiGroups": [
							"coordination.k8s.io",
						]
						"resources": [
							"leases",
						]
						"verbs": [
							"create",
						]
					},
					{
						"apiGroups": [
							"coordination.k8s.io",
						]
						"resources": [
							"leases",
						]
						"resourceNames": [
							"elastic-operator-leader",
						]
						"verbs": [
							"get",
							"watch",
							"update",
						]
					},
					{
						"apiGroups": [
							"",
						]
						"resources": [
							"endpoints",
						]
						"verbs": [
							"get",
							"list",
							"watch",
						]
					},
					{
						"apiGroups": [
							"",
						]
						"resources": [
							"pods",
							"events",
							"persistentvolumeclaims",
							"secrets",
							"services",
							"configmaps",
						]
						"verbs": [
							"get",
							"list",
							"watch",
							"create",
							"update",
							"patch",
							"delete",
						]
					},
					{
						"apiGroups": [
							"apps",
						]
						"resources": [
							"deployments",
							"statefulsets",
							"daemonsets",
						]
						"verbs": [
							"get",
							"list",
							"watch",
							"create",
							"update",
							"patch",
							"delete",
						]
					},
					{
						"apiGroups": [
							"policy",
						]
						"resources": [
							"poddisruptionbudgets",
						]
						"verbs": [
							"get",
							"list",
							"watch",
							"create",
							"update",
							"patch",
							"delete",
						]
					},
					{
						"apiGroups": [
							"elasticsearch.k8s.elastic.co",
						]
						"resources": [
							"elasticsearches",
							"elasticsearches/status",
							"elasticsearches/finalizers",
						]
						"verbs": [
							"get",
							"list",
							"watch",
							"create",
							"update",
							"patch",
						]
					},
					{
						"apiGroups": [
							"autoscaling.k8s.elastic.co",
						]
						"resources": [
							"elasticsearchautoscalers",
							"elasticsearchautoscalers/status",
							"elasticsearchautoscalers/finalizers",
						]
						"verbs": [
							"get",
							"list",
							"watch",
							"create",
							"update",
							"patch",
						]
					},
					{
						"apiGroups": [
							"kibana.k8s.elastic.co",
						]
						"resources": [
							"kibanas",
							"kibanas/status",
							"kibanas/finalizers",
						]
						"verbs": [
							"get",
							"list",
							"watch",
							"create",
							"update",
							"patch",
						]
					},
					{
						"apiGroups": [
							"apm.k8s.elastic.co",
						]
						"resources": [
							"apmservers",
							"apmservers/status",
							"apmservers/finalizers",
						]
						"verbs": [
							"get",
							"list",
							"watch",
							"create",
							"update",
							"patch",
						]
					},
					{
						"apiGroups": [
							"enterprisesearch.k8s.elastic.co",
						]
						"resources": [
							"enterprisesearches",
							"enterprisesearches/status",
							"enterprisesearches/finalizers",
						]
						"verbs": [
							"get",
							"list",
							"watch",
							"create",
							"update",
							"patch",
						]
					},
					{
						"apiGroups": [
							"beat.k8s.elastic.co",
						]
						"resources": [
							"beats",
							"beats/status",
							"beats/finalizers",
						]
						"verbs": [
							"get",
							"list",
							"watch",
							"create",
							"update",
							"patch",
						]
					},
					{
						"apiGroups": [
							"agent.k8s.elastic.co",
						]
						"resources": [
							"agents",
							"agents/status",
							"agents/finalizers",
						]
						"verbs": [
							"get",
							"list",
							"watch",
							"create",
							"update",
							"patch",
						]
					},
					{
						"apiGroups": [
							"maps.k8s.elastic.co",
						]
						"resources": [
							"elasticmapsservers",
							"elasticmapsservers/status",
							"elasticmapsservers/finalizers",
						]
						"verbs": [
							"get",
							"list",
							"watch",
							"create",
							"update",
							"patch",
						]
					},
					{
						"apiGroups": [
							"stackconfigpolicy.k8s.elastic.co",
						]
						"resources": [
							"stackconfigpolicies",
							"stackconfigpolicies/status",
							"stackconfigpolicies/finalizers",
						]
						"verbs": [
							"get",
							"list",
							"watch",
							"create",
							"update",
							"patch",
						]
					},
					{
						"apiGroups": [
							"storage.k8s.io",
						]
						"resources": [
							"storageclasses",
						]
						"verbs": [
							"get",
							"list",
							"watch",
						]
					},
					{
						"apiGroups": [
							"admissionregistration.k8s.io",
						]
						"resources": [
							"validatingwebhookconfigurations",
						]
						"verbs": [
							"get",
							"list",
							"watch",
							"create",
							"update",
							"patch",
							"delete",
						]
					},
					{
						"apiGroups": [
							"",
						]
						"resources": [
							"nodes",
						]
						"verbs": [
							"get",
							"list",
							"watch",
						]
					},
				]
			},
			{
				"apiVersion": "rbac.authorization.k8s.io/v1"
				"kind":       "ClusterRole"
				"metadata": {
					"name": "elastic-operator-view"
					"labels": {
						"rbac.authorization.k8s.io/aggregate-to-view":  "true"
						"rbac.authorization.k8s.io/aggregate-to-edit":  "true"
						"rbac.authorization.k8s.io/aggregate-to-admin": "true"
						"control-plane":                                "elastic-operator"
						"app.kubernetes.io/version":                    "2.6.1"
					}
				}
				"rules": [
					{
						"apiGroups": [
							"elasticsearch.k8s.elastic.co",
						]
						"resources": [
							"elasticsearches",
						]
						"verbs": [
							"get",
							"list",
							"watch",
						]
					},
					{
						"apiGroups": [
							"autoscaling.k8s.elastic.co",
						]
						"resources": [
							"elasticsearchautoscalers",
						]
						"verbs": [
							"get",
							"list",
							"watch",
						]
					},
					{
						"apiGroups": [
							"apm.k8s.elastic.co",
						]
						"resources": [
							"apmservers",
						]
						"verbs": [
							"get",
							"list",
							"watch",
						]
					},
					{
						"apiGroups": [
							"kibana.k8s.elastic.co",
						]
						"resources": [
							"kibanas",
						]
						"verbs": [
							"get",
							"list",
							"watch",
						]
					},
					{
						"apiGroups": [
							"enterprisesearch.k8s.elastic.co",
						]
						"resources": [
							"enterprisesearches",
						]
						"verbs": [
							"get",
							"list",
							"watch",
						]
					},
					{
						"apiGroups": [
							"beat.k8s.elastic.co",
						]
						"resources": [
							"beats",
						]
						"verbs": [
							"get",
							"list",
							"watch",
						]
					},
					{
						"apiGroups": [
							"agent.k8s.elastic.co",
						]
						"resources": [
							"agents",
						]
						"verbs": [
							"get",
							"list",
							"watch",
						]
					},
					{
						"apiGroups": [
							"maps.k8s.elastic.co",
						]
						"resources": [
							"elasticmapsservers",
						]
						"verbs": [
							"get",
							"list",
							"watch",
						]
					},
					{
						"apiGroups": [
							"stackconfigpolicy.k8s.elastic.co",
						]
						"resources": [
							"stackconfigpolicies",
						]
						"verbs": [
							"get",
							"list",
							"watch",
						]
					},
				]
			},
			{
				"apiVersion": "rbac.authorization.k8s.io/v1"
				"kind":       "ClusterRole"
				"metadata": {
					"name": "elastic-operator-edit"
					"labels": {
						"rbac.authorization.k8s.io/aggregate-to-edit":  "true"
						"rbac.authorization.k8s.io/aggregate-to-admin": "true"
						"control-plane":                                "elastic-operator"
						"app.kubernetes.io/version":                    "2.6.1"
					}
				}
				"rules": [
					{
						"apiGroups": [
							"elasticsearch.k8s.elastic.co",
						]
						"resources": [
							"elasticsearches",
						]
						"verbs": [
							"create",
							"delete",
							"deletecollection",
							"patch",
							"update",
						]
					},
					{
						"apiGroups": [
							"autoscaling.k8s.elastic.co",
						]
						"resources": [
							"elasticsearchautoscalers",
						]
						"verbs": [
							"create",
							"delete",
							"deletecollection",
							"patch",
							"update",
						]
					},
					{
						"apiGroups": [
							"apm.k8s.elastic.co",
						]
						"resources": [
							"apmservers",
						]
						"verbs": [
							"create",
							"delete",
							"deletecollection",
							"patch",
							"update",
						]
					},
					{
						"apiGroups": [
							"kibana.k8s.elastic.co",
						]
						"resources": [
							"kibanas",
						]
						"verbs": [
							"create",
							"delete",
							"deletecollection",
							"patch",
							"update",
						]
					},
					{
						"apiGroups": [
							"enterprisesearch.k8s.elastic.co",
						]
						"resources": [
							"enterprisesearches",
						]
						"verbs": [
							"create",
							"delete",
							"deletecollection",
							"patch",
							"update",
						]
					},
					{
						"apiGroups": [
							"beat.k8s.elastic.co",
						]
						"resources": [
							"beats",
						]
						"verbs": [
							"create",
							"delete",
							"deletecollection",
							"patch",
							"update",
						]
					},
					{
						"apiGroups": [
							"agent.k8s.elastic.co",
						]
						"resources": [
							"agents",
						]
						"verbs": [
							"create",
							"delete",
							"deletecollection",
							"patch",
							"update",
						]
					},
					{
						"apiGroups": [
							"maps.k8s.elastic.co",
						]
						"resources": [
							"elasticmapsservers",
						]
						"verbs": [
							"create",
							"delete",
							"deletecollection",
							"patch",
							"update",
						]
					},
					{
						"apiGroups": [
							"stackconfigpolicy.k8s.elastic.co",
						]
						"resources": [
							"stackconfigpolicies",
						]
						"verbs": [
							"create",
							"delete",
							"deletecollection",
							"patch",
							"update",
						]
					},
				]
			},
			{
				"apiVersion": "rbac.authorization.k8s.io/v1"
				"kind":       "ClusterRoleBinding"
				"metadata": {
					"name": "elastic-operator"
					"labels": {
						"control-plane":             "elastic-operator"
						"app.kubernetes.io/version": "2.6.1"
					}
				}
				"roleRef": {
					"apiGroup": "rbac.authorization.k8s.io"
					"kind":     "ClusterRole"
					"name":     "elastic-operator"
				}
				"subjects": [
					{
						"kind":      "ServiceAccount"
						"name":      "elastic-operator"
						"namespace": parameter.namespace
					},
				]
			},
			{
				"apiVersion": "v1"
				"kind":       "Service"
				"metadata": {
					"name":      "elastic-webhook-server"
					"namespace": parameter.namespace
					"labels": {
						"control-plane":             "elastic-operator"
						"app.kubernetes.io/version": "2.6.1"
					}
				}
				"spec": {
					"ports": [
						{
							"name":       "https"
							"port":       443
							"targetPort": 9443
						},
					]
					"selector": {
						"control-plane": "elastic-operator"
					}
				}
			},
			{
				"apiVersion": "apps/v1"
				"kind":       "StatefulSet"
				"metadata": {
					"name":      "elastic-operator"
					"namespace": parameter.namespace
					"labels": {
						"control-plane":             "elastic-operator"
						"app.kubernetes.io/version": "2.6.1"
					}
				}
				"spec": {
					"selector": {
						"matchLabels": {
							"control-plane": "elastic-operator"
						}
					}
					"serviceName": "elastic-operator"
					"replicas":    1
					"template": {
						"metadata": {
							"annotations": {
								"co.elastic.logs/raw": "[{\"type\":\"container\",\"json.keys_under_root\":true,\"paths\":[\"/var/log/containers/*${data.kubernetes.container.id}.log\"],\"processors\":[{\"convert\":{\"mode\":\"rename\",\"ignore_missing\":true,\"fields\":[{\"from\":\"error\",\"to\":\"_error\"}]}},{\"convert\":{\"mode\":\"rename\",\"ignore_missing\":true,\"fields\":[{\"from\":\"_error\",\"to\":\"error.message\"}]}},{\"convert\":{\"mode\":\"rename\",\"ignore_missing\":true,\"fields\":[{\"from\":\"source\",\"to\":\"_source\"}]}},{\"convert\":{\"mode\":\"rename\",\"ignore_missing\":true,\"fields\":[{\"from\":\"_source\",\"to\":\"event.source\"}]}}]}]"
								"checksum/config":     "0167077654d0c8023b9201c09b02b9213c73d47b50aab990b1e2e8cd41653ca7"
							}
							"labels": {
								"control-plane": "elastic-operator"
							}
						}
						"spec": {
							"terminationGracePeriodSeconds": 10
							"serviceAccountName":            "elastic-operator"
							"securityContext": {
								"runAsNonRoot": true
							}
							"containers": [
								{
									"image":           "docker.elastic.co/eck/eck-operator:2.6.1"
									"imagePullPolicy": "IfNotPresent"
									"name":            "manager"
									"args": [
										"manager",
										"--config=/conf/eck.yaml",
									]
									"securityContext": {
										"allowPrivilegeEscalation": false
										"capabilities": {
											"drop": [
												"ALL",
											]
										}
										"readOnlyRootFilesystem": true
										"runAsNonRoot":           true
									}
									"env": [
										{
											"name": "OPERATOR_NAMESPACE"
											"valueFrom": {
												"fieldRef": {
													"fieldPath": "metadata.namespace"
												}
											}
										},
										{
											"name": "POD_IP"
											"valueFrom": {
												"fieldRef": {
													"fieldPath": "status.podIP"
												}
											}
										},
										{
											"name":  "WEBHOOK_SECRET"
											"value": "elastic-webhook-server-cert"
										},
									]
									"resources": {
										"limits": {
											"cpu":    1
											"memory": "1Gi"
										}
										"requests": {
											"cpu":    "100m"
											"memory": "150Mi"
										}
									}
									"ports": [
										{
											"containerPort": 9443
											"name":          "https-webhook"
											"protocol":      "TCP"
										},
									]
									"volumeMounts": [
										{
											"mountPath": "/conf"
											"name":      "conf"
											"readOnly":  true
										},
										{
											"mountPath": "/tmp/k8s-webhook-server/serving-certs"
											"name":      "cert"
											"readOnly":  true
										},
									]
								},
							]
							"volumes": [
								{
									"name": "conf"
									"configMap": {
										"name": "elastic-operator"
									}
								},
								{
									"name": "cert"
									"secret": {
										"defaultMode": 420
										"secretName":  "elastic-webhook-server-cert"
									}
								},
							]
						}
					}
				}
			},
			{
				"apiVersion": "admissionregistration.k8s.io/v1"
				"kind":       "ValidatingWebhookConfiguration"
				"metadata": {
					"name": "elastic-webhook.k8s.elastic.co"
					"labels": {
						"control-plane":             "elastic-operator"
						"app.kubernetes.io/version": "2.6.1"
					}
				}
				"webhooks": [
					{
						"clientConfig": {
							"caBundle": "Cg=="
							"service": {
								"name":      "elastic-webhook-server"
								"namespace": parameter.namespace
								"path":      "/validate-agent-k8s-elastic-co-v1alpha1-agent"
							}
						}
						"failurePolicy": "Ignore"
						"name":          "elastic-agent-validation-v1alpha1.k8s.elastic.co"
						"matchPolicy":   "Exact"
						"admissionReviewVersions": [
							"v1beta1",
						]
						"sideEffects": "None"
						"rules": [
							{
								"apiGroups": [
									"agent.k8s.elastic.co",
								]
								"apiVersions": [
									"v1alpha1",
								]
								"operations": [
									"CREATE",
									"UPDATE",
								]
								"resources": [
									"agents",
								]
							},
						]
					},
					{
						"clientConfig": {
							"caBundle": "Cg=="
							"service": {
								"name":      "elastic-webhook-server"
								"namespace": parameter.namespace
								"path":      "/validate-apm-k8s-elastic-co-v1-apmserver"
							}
						}
						"failurePolicy": "Ignore"
						"name":          "elastic-apm-validation-v1.k8s.elastic.co"
						"matchPolicy":   "Exact"
						"admissionReviewVersions": [
							"v1beta1",
						]
						"sideEffects": "None"
						"rules": [
							{
								"apiGroups": [
									"apm.k8s.elastic.co",
								]
								"apiVersions": [
									"v1",
								]
								"operations": [
									"CREATE",
									"UPDATE",
								]
								"resources": [
									"apmservers",
								]
							},
						]
					},
					{
						"clientConfig": {
							"caBundle": "Cg=="
							"service": {
								"name":      "elastic-webhook-server"
								"namespace": parameter.namespace
								"path":      "/validate-apm-k8s-elastic-co-v1beta1-apmserver"
							}
						}
						"failurePolicy": "Ignore"
						"name":          "elastic-apm-validation-v1beta1.k8s.elastic.co"
						"matchPolicy":   "Exact"
						"admissionReviewVersions": [
							"v1beta1",
						]
						"sideEffects": "None"
						"rules": [
							{
								"apiGroups": [
									"apm.k8s.elastic.co",
								]
								"apiVersions": [
									"v1beta1",
								]
								"operations": [
									"CREATE",
									"UPDATE",
								]
								"resources": [
									"apmservers",
								]
							},
						]
					},
					{
						"clientConfig": {
							"caBundle": "Cg=="
							"service": {
								"name":      "elastic-webhook-server"
								"namespace": parameter.namespace
								"path":      "/validate-beat-k8s-elastic-co-v1beta1-beat"
							}
						}
						"failurePolicy": "Ignore"
						"name":          "elastic-beat-validation-v1beta1.k8s.elastic.co"
						"matchPolicy":   "Exact"
						"admissionReviewVersions": [
							"v1beta1",
						]
						"sideEffects": "None"
						"rules": [
							{
								"apiGroups": [
									"beat.k8s.elastic.co",
								]
								"apiVersions": [
									"v1beta1",
								]
								"operations": [
									"CREATE",
									"UPDATE",
								]
								"resources": [
									"beats",
								]
							},
						]
					},
					{
						"clientConfig": {
							"caBundle": "Cg=="
							"service": {
								"name":      "elastic-webhook-server"
								"namespace": parameter.namespace
								"path":      "/validate-enterprisesearch-k8s-elastic-co-v1-enterprisesearch"
							}
						}
						"failurePolicy": "Ignore"
						"name":          "elastic-ent-validation-v1.k8s.elastic.co"
						"matchPolicy":   "Exact"
						"admissionReviewVersions": [
							"v1beta1",
						]
						"sideEffects": "None"
						"rules": [
							{
								"apiGroups": [
									"enterprisesearch.k8s.elastic.co",
								]
								"apiVersions": [
									"v1",
								]
								"operations": [
									"CREATE",
									"UPDATE",
								]
								"resources": [
									"enterprisesearches",
								]
							},
						]
					},
					{
						"clientConfig": {
							"caBundle": "Cg=="
							"service": {
								"name":      "elastic-webhook-server"
								"namespace": parameter.namespace
								"path":      "/validate-enterprisesearch-k8s-elastic-co-v1beta1-enterprisesearch"
							}
						}
						"failurePolicy": "Ignore"
						"name":          "elastic-ent-validation-v1beta1.k8s.elastic.co"
						"matchPolicy":   "Exact"
						"admissionReviewVersions": [
							"v1beta1",
						]
						"sideEffects": "None"
						"rules": [
							{
								"apiGroups": [
									"enterprisesearch.k8s.elastic.co",
								]
								"apiVersions": [
									"v1beta1",
								]
								"operations": [
									"CREATE",
									"UPDATE",
								]
								"resources": [
									"enterprisesearches",
								]
							},
						]
					},
					{
						"clientConfig": {
							"caBundle": "Cg=="
							"service": {
								"name":      "elastic-webhook-server"
								"namespace": parameter.namespace
								"path":      "/validate-elasticsearch-k8s-elastic-co-v1-elasticsearch"
							}
						}
						"failurePolicy": "Ignore"
						"name":          "elastic-es-validation-v1.k8s.elastic.co"
						"matchPolicy":   "Exact"
						"admissionReviewVersions": [
							"v1beta1",
						]
						"sideEffects": "None"
						"rules": [
							{
								"apiGroups": [
									"elasticsearch.k8s.elastic.co",
								]
								"apiVersions": [
									"v1",
								]
								"operations": [
									"CREATE",
									"UPDATE",
								]
								"resources": [
									"elasticsearches",
								]
							},
						]
					},
					{
						"clientConfig": {
							"caBundle": "Cg=="
							"service": {
								"name":      "elastic-webhook-server"
								"namespace": parameter.namespace
								"path":      "/validate-elasticsearch-k8s-elastic-co-v1beta1-elasticsearch"
							}
						}
						"failurePolicy": "Ignore"
						"name":          "elastic-es-validation-v1beta1.k8s.elastic.co"
						"matchPolicy":   "Exact"
						"admissionReviewVersions": [
							"v1beta1",
						]
						"sideEffects": "None"
						"rules": [
							{
								"apiGroups": [
									"elasticsearch.k8s.elastic.co",
								]
								"apiVersions": [
									"v1beta1",
								]
								"operations": [
									"CREATE",
									"UPDATE",
								]
								"resources": [
									"elasticsearches",
								]
							},
						]
					},
					{
						"clientConfig": {
							"caBundle": "Cg=="
							"service": {
								"name":      "elastic-webhook-server"
								"namespace": parameter.namespace
								"path":      "/validate-kibana-k8s-elastic-co-v1-kibana"
							}
						}
						"failurePolicy": "Ignore"
						"name":          "elastic-kb-validation-v1.k8s.elastic.co"
						"matchPolicy":   "Exact"
						"admissionReviewVersions": [
							"v1beta1",
						]
						"sideEffects": "None"
						"rules": [
							{
								"apiGroups": [
									"kibana.k8s.elastic.co",
								]
								"apiVersions": [
									"v1",
								]
								"operations": [
									"CREATE",
									"UPDATE",
								]
								"resources": [
									"kibanas",
								]
							},
						]
					},
					{
						"clientConfig": {
							"caBundle": "Cg=="
							"service": {
								"name":      "elastic-webhook-server"
								"namespace": parameter.namespace
								"path":      "/validate-kibana-k8s-elastic-co-v1beta1-kibana"
							}
						}
						"failurePolicy": "Ignore"
						"name":          "elastic-kb-validation-v1beta1.k8s.elastic.co"
						"matchPolicy":   "Exact"
						"admissionReviewVersions": [
							"v1beta1",
						]
						"sideEffects": "None"
						"rules": [
							{
								"apiGroups": [
									"kibana.k8s.elastic.co",
								]
								"apiVersions": [
									"v1beta1",
								]
								"operations": [
									"CREATE",
									"UPDATE",
								]
								"resources": [
									"kibanas",
								]
							},
						]
					},
					{
						"clientConfig": {
							"caBundle": "Cg=="
							"service": {
								"name":      "elastic-webhook-server"
								"namespace": parameter.namespace
								"path":      "/validate-autoscaling-k8s-elastic-co-v1alpha1-elasticsearchautoscaler"
							}
						}
						"failurePolicy": "Ignore"
						"name":          "elastic-esa-validation-v1alpha1.k8s.elastic.co"
						"matchPolicy":   "Exact"
						"admissionReviewVersions": [
							"v1beta1",
						]
						"sideEffects": "None"
						"rules": [
							{
								"apiGroups": [
									"autoscaling.k8s.elastic.co",
								]
								"apiVersions": [
									"v1alpha1",
								]
								"operations": [
									"CREATE",
									"UPDATE",
								]
								"resources": [
									"elasticsearchautoscalers",
								]
							},
						]
					},
					{
						"clientConfig": {
							"caBundle": "Cg=="
							"service": {
								"name":      "elastic-webhook-server"
								"namespace": parameter.namespace
								"path":      "/validate-scp-k8s-elastic-co-v1alpha1-stackconfigpolicies"
							}
						}
						"failurePolicy": "Ignore"
						"name":          "elastic-scp-validation-v1alpha1.k8s.elastic.co"
						"matchPolicy":   "Exact"
						"admissionReviewVersions": [
							"v1",
							"v1beta1",
						]
						"sideEffects": "None"
						"rules": [
							{
								"apiGroups": [
									"stackconfigpolicy.k8s.elastic.co",
								]
								"apiVersions": [
									"v1alpha1",
								]
								"operations": [
									"CREATE",
									"UPDATE",
								]
								"resources": [
									"stackconfigpolicies",
								]
							},
						]
					},
				]
			},
		]
	}
}
