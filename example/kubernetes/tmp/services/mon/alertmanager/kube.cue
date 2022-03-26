package kube

service: alertmanager: {
	apiVersion: "v1"
	kind:       "Service"
	metadata: {
		annotations: {
			"prometheus.io/scrape": "true"
			"prometheus.io/path":   "/metrics"
		}
		name: "alertmanager"
		labels: app: "alertmanager"
	}
	spec: {
		ports: [{
			name:       "main"
			port:       9093
			protocol:   "TCP"
			targetPort: 9093
		}]
		selector: app: "alertmanager"
	}
}
deployment: alertmanager: {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: name: "alertmanager"
	spec: {
		selector: matchLabels: app: "alertmanager"
		replicas: 1
		template: {
			metadata: {
				name: "alertmanager"
				labels: app: "alertmanager"
			}
			spec: {
				containers: [{
					image: "prom/alertmanager:v0.15.2"
					args: [
						"--config.file=/etc/alertmanager/alerts.yaml",
						"--storage.path=/alertmanager",
						"--web.external-url=https://alertmanager.example.com",
					]
					ports: [{
						name:          "alertmanager"
						containerPort: 9093
					}]
					name: "alertmanager"
					volumeMounts: [{
						name:      "config-volume"
						mountPath: "/etc/alertmanager"
					}, {
						name:      "alertmanager"
						mountPath: "/alertmanager"
					}]
				}]
				volumes: [{
					name: "config-volume"
					configMap: name: "alertmanager"
				}, {
					name: "alertmanager"
					emptyDir: {}
				}]
			}
		}
	}
}
