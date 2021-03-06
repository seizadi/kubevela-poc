package kube

service: tasks: {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		name: "tasks"
		labels: {
			app:       "tasks"
			component: "infra"
		}
	}
	spec: {
		type:           "LoadBalancer"
		loadBalancerIP: "1.2.3.4" // static ip
		ports: [{
			port:       443
			targetPort: 7443
			protocol:   "TCP"
			name:       "http"
		}]
		selector: app: "tasks"
	}
}
