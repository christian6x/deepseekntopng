{{- define "ntopngpack.namespace" -}}
{{- if .Release.Namespace }}
{{- .Release.Namespace }} 
{{- else }}
{{- .Values.namespace | default "default" }} 
{{- end }}
{{- end }}

{{- define "ntopngpack.fullname" -}}
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

{{- define "ntopngpack.labels" -}}
app: {{ include "ntopngpack.fullname" . }}
chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
release: {{ .Release.Name }}
heritage: {{ .Release.Service }}
{{- end }}

{{- define "ntopngpack.selectorLabels" -}}
app: {{ include "ntopngpack.fullname" . }}
release: {{ .Release.Name }}
{{- end }}
