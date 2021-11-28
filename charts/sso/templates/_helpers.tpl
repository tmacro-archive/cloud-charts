{{/*
Expand the name of the chart.
*/}}
{{- define "sso.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "sso.fullname" -}}
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
{{- define "sso.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "sso.labels" -}}
helm.sh/chart: {{ include "sso.chart" . }}
{{ include "sso.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "sso.selectorLabels" -}}
app.kubernetes.io/name: {{ include "sso.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common Helm labels
*/}}
{{- define "sso.helmLabels" -}}
helm.sh/chart: {{ include "sso.chart" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Create the name of the authelia postgres credentials secret
*/}}
{{- define "sso.autheliaSecretName" -}}
{{- printf "%s-%s" (include "sso.fullname" .) "authelia-service-credentials" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create the authelia users database file
*/}}
{{- define "sso.autheliaSecretUserDB" -}}
{{- if .Values.authelia.users }}
users:
  {{- .Values.authelia.users | default (dict) | toYaml | nindent 2 }}
{{- else }}
users: {}
{{- end }}
{{- end }}
