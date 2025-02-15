package main

controllerClusterRole: {
	apiVersion: "rbac.authorization.k8s.io/v1"
	kind:       "ClusterRole"
	metadata: name: "kubernetes-cronhpa-controller-role"
	rules: [{
		apiGroups: ["*"]
		resources: ["*/scale"]
		verbs: ["get", "list", "update"]
	}, {
		apiGroups: ["extensions"]
		resources: ["*"]
		verbs: ["get", "list", "watch", "update"]
	}, {
		apiGroups: ["apps"]
		resources: ["*"]
		verbs: ["get", "list", "watch", "update"]
	}, {
		apiGroups: [""]
		resources: ["configmaps", "events"]
		verbs: ["get", "list", "watch", "create", "update", "patch"]
	}, {
		apiGroups: ["autoscaling"]
		resources: ["horizontalpodautoscalers"]
		verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
	}, {
		apiGroups: ["autoscaling.alibabacloud.com"]
		resources: ["cronhorizontalpodautoscalers", "elasticworkloads"]
		verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
	}, {
		apiGroups: ["admissionregistration.k8s.io"]
		resources: ["mutatingwebhookconfigurations", "validatingwebhookconfigurations"]
		verbs: ["get", "list", "watch", "create", "update", "patch", "delete", "patch"]
	}]
}
