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

{{- define "node-services.selectorLabels" -}}
app.kubernetes.io/name: {{ include "node-services.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Name for haproxy
*/}}
{{- define "node-services.proxy.name" -}}
{{- include "node-services.name" . }}-haproxy
{{- end }}

{{/*
FQDN for haproxy
*/}}
{{- define "node-services.proxy.fullname" -}}
{{- include "node-services.fullname" . }}-haproxy
{{- end }}

{{/*
Selector labels for haproxy
*/}}
{{- define "node-services.proxy.selectorLabels" -}}
app.kubernetes.io/name: {{ include "node-services.proxy.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Name for bind
*/}}
{{- define "node-services.bind.name" -}}
{{- include "node-services.name" . }}-bind
{{- end }}

{{/*
FQDN for bind
*/}}
{{- define "node-services.bind.fullname" -}}
{{- include "node-services.fullname" . }}-bind
{{- end }}

{{/*
Selector labels for bind
*/}}
{{- define "node-services.bind.selectorLabels" -}}
app.kubernetes.io/name: {{ include "node-services.bind.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Name for dnsmasq
*/}}
{{- define "node-services.dnsmasq.name" -}}
{{- include "node-services.name" . }}-dnsmasq
{{- end }}

{{/*
FQDN for dnsmasq
*/}}
{{- define "node-services.dnsmasq.fullname" -}}
{{- include "node-services.fullname" . }}-dnsmasq
{{- end }}

{{/*
Selector labels for dnsmasq
*/}}
{{- define "node-services.dnsmasq.selectorLabels" -}}
app.kubernetes.io/name: {{ include "node-services.dnsmasq.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
