package kube

service: nginx: {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		name: "nginx"
		labels: {
			app:       "nginx"
			component: "proxy"
		}
	}
	spec: {
		type:           "LoadBalancer"
		loadBalancerIP: "1.3.4.5"
		ports: [{
			port: 80 // the port that this service should serve on
			// the container on each pod to connect to, can be a name
			// (e.g. 'www') or a number (e.g. 80)
			targetPort: 80
			protocol:   "TCP"
			name:       "http"
		}, {
			port:     443
			protocol: "TCP"
			name:     "https"
		}]
		// just like the selector in the replication controller,
		// but this time it identifies the set of pods to load balance
		// traffic to.
		selector: {
			app: "nginx"
		}
	}
}
