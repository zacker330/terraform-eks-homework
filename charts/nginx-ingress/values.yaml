{
  "controller": {
    "name": "controller",
    "kind": "deployment",
    "annotations": {},
    "nginxplus": false,
    "nginxReloadTimeout": 60000,
    "appprotect": {
      "enable": false
    },
    "appprotectdos": {
      "enable": false,
      "debug": false,
      "maxWorkers": 0,
      "maxDaemons": 0,
      "memory": 0
    },
    "hostNetwork": false,
    "dnsPolicy": "ClusterFirst",
    "nginxDebug": false,
    "logLevel": 1,
    "customPorts": [],
    "image": {
      "repository": "nginx/nginx-ingress",
      "tag": "3.1.0",
      "pullPolicy": "IfNotPresent"
    },
    "lifecycle": {},
    "customConfigMap": "",
    "config": {
      "annotations": {},
      "entries": {}
    },
    "defaultTLS": {
      "cert": "",
      "key": "",
      "secret": ""
    },
    "wildcardTLS": {
      "cert": "",
      "key": "",
      "secret": ""
    },
    "terminationGracePeriodSeconds": 30,
    "autoscaling": {
      "enabled": true,
      "annotations": {},
      "minReplicas": 1,
      "maxReplicas": 3,
      "targetCPUUtilizationPercentage": 50,
      "targetMemoryUtilizationPercentage": 50
    },
    "resources": {
      "requests": {
        "cpu": "10m",
        "memory": "12Mi"
      }
    },
    "tolerations": [],
    "affinity": {},
    "env": [],
    "volumes": [],
    "volumeMounts": [],
    "initContainers": [],
    "minReadySeconds": 0,
    "podDisruptionBudget": {
      "enabled": false,
      "annotations": {}
    },
    "strategy": {},
    "extraContainers": [],
    "replicaCount": 2,
    "ingressClass": "nginx",
    "setAsDefaultIngress": false,
    "watchNamespace": "",
    "watchNamespaceLabel": "",
    "watchSecretNamespace": "",
    "enableCustomResources": true,
    "enablePreviewPolicies": false,
    "enableOIDC": false,
    "includeYear": false,
    "enableTLSPassthrough": false,
    "enableCertManager": false,
    "enableExternalDNS": false,
    "globalConfiguration": {
      "create": false,
      "spec": {}
    },
    "enableSnippets": false,
    "healthStatus": true,
    "healthStatusURI": "/nginx-health",
    "nginxStatus": {
      "enable": true,
      "port": 8080,
      "allowCidrs": "127.0.0.1"
    },
    "service": {
      "create": true,
      "type": "LoadBalancer",
      "externalTrafficPolicy": "Local",
      "annotations": {
        "service.beta.kubernetes.io/aws-load-balancer-backend-protocol": "tcp",
        "service.beta.kubernetes.io/aws-load-balancer-cross-zone-load-balancing-enabled": "false",
        "service.beta.kubernetes.io/aws-load-balancer-type": "nlb"
      },
      "extraLabels": {},
      "loadBalancerIP": "",
      "externalIPs": [],
      "loadBalancerSourceRanges": [],
      "httpPort": {
        "enable": true,
        "port": 80,
        "targetPort": 80
      },
      "httpsPort": {
        "enable": true,
        "port": 443,
        "targetPort": 443
      },
      "customPorts": []
    },
    "serviceAccount": {
      "annotations": {},
      "imagePullSecretName": ""
    },
    "serviceMonitor": {
      "create": false,
      "labels": {},
      "selectorMatchLabels": {},
      "endpoints": []
    },
    "reportIngressStatus": {
      "enable": true,
      "ingressLink": "",
      "enableLeaderElection": true,
      "annotations": {}
    },
    "pod": {
      "annotations": {},
      "extraLabels": {}
    },
    "readyStatus": {
      "enable": true,
      "port": 8081,
      "initialDelaySeconds": 0
    },
    "enableLatencyMetrics": false,
    "disableIPV6": false,
    "readOnlyRootFilesystem": false
  },
  "rbac": {
    "create": true
  },
  "prometheus": {
    "create": true,
    "port": 9113,
    "secret": "",
    "scheme": "http"
  },
  "serviceInsight": {
    "create": false,
    "port": 9114,
    "secret": "",
    "scheme": "http"
  },
  "nginxServiceMesh": {
    "enable": false,
    "enableEgress": false
  }
}