package kube

service: goget: {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		name: "goget"
		labels: {
			app:       "goget"
			component: "proxy"
		}
	}
	spec: {
		type:           "LoadBalancer"
		loadBalancerIP: "1.3.5.7" // static ip
		ports: [{
			port:       443
			targetPort: 7443
			protocol:   "TCP"
			name:       "https"
		}]
		selector: app: "goget"
	}
}
