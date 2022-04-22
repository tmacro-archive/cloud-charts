{{/*
Expand the name of the chart.
*/}}
{{- define "node-services.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "node-services.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "node-services-dns.name" -}}
{{- include "node-services.name" . }}{{ default "dns" .Values.dnsNameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "node-services-dns.fullname" -}}
{{- if .Values.dnsFullNameOverride }}
{{- .Values.dnsFullNameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default "dns" .Values.dnsNameOverride }}
{{- $chartName := default .Chart.Name .Values.nameOverride }}
{{- if contains $chartName .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}-{{ $name }}
{{- else }}
{{- printf "%s-%s-%s" .Release.Name $chartName $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "node-services-proxy.name" -}}
{{- include "node-services.name" . }}{{ default "proxy" .Values.proxyNameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "node-services-proxy.fullname" -}}
{{- if .Values.proxyFullNameOverride }}
{{- .Values.proxyFullNameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default "proxy" .Values.proxyNameOverride }}
{{- $chartName := default .Chart.Name .Values.nameOverride }}
{{- if contains $chartName .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}-{{ $name }}
{{- else }}
{{- printf "%s-%s-%s" .Release.Name $chartName $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "node-services.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "node-services.labels" -}}
helm.sh/chart: {{ include "node-services.chart" . }}
{{ include "node-services.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "node-services.selectorLabels" -}}
app.kubernetes.io/name: {{ include "node-services.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "node-services-dns.selectorLabels" -}}
app.kubernetes.io/name: {{ include "node-services-dns.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "node-services-proxy.selectorLabels" -}}
app.kubernetes.io/name: {{ include "node-services-proxy.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "node-services.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "node-services.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
