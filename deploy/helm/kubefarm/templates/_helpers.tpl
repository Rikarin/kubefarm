{{/* vim: set filetype=gohtmltmpl: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "kubefarm.name" -}}
{{- default "kubefarm" .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "ltsp.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default "ltsp" .Values.nameOverride -}}
{{- if eq (.Release.Name | upper) "RELEASE-NAME" -}}
{{- $name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "kubefarm.dhcpOptionKey" -}}
{{- if or (regexMatch "^[0-9]+$" .) (regexFind ":" .) -}}
{{- . -}}
{{- else -}}
{{- if eq . "broadcast" -}}
{{/* https://www.mail-archive.com/dnsmasq-discuss@lists.thekelleys.org.uk/msg14137.html */}}
{{- "28" -}}
{{- else -}}
{{- printf "option:%s" . }}
{{- end -}}
{{- end -}}
{{- end -}}

{{- define "kubefarm.includeTags" -}}
{{- $local := dict "first" true -}}
{{- range $t := . -}}
{{- if not $local.first }}
{{ end -}}
{{ printf "INCLUDE=tag_%s" $t }}
{{- $_ := set $local "first" false -}}
{{- end -}}
{{- end -}}

{{- define "kubefarm.kubernetesLabels" -}}
{{- $local := dict "first" true -}}
{{- range $k, $v := . -}}
{{- if not $local.first -}},{{- end -}}
{{ $k }}={{ $v | default "" }}
{{- $_ := set $local "first" false -}}
{{- end -}}
{{- end -}}

{{- define "kubefarm.kubernetesTaints" -}}
{{- $local := dict "first" true -}}
{{- range $t := . -}}
{{- if not $local.first -}},{{- end -}}
{{ $t.key }}={{ $t.value | default "" }}:{{ $t.effect }}
{{- $_ := set $local "first" false -}}
{{- end -}}
{{- end -}}
