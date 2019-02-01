{{/*
Expand the name of the chart.
*/}}
{{- define "dremio.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "dremio.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Calcuate the heap memory used by Dremio
*/}}
{{- define "HeapMemory" -}}
{{- $input := int . -}}
{{- if ge $input 32768 -}}
8192
{{- else if ge $input 16384 -}}
4096
{{- else if ge $input 4096 -}}
2048
{{- else -}}
{{- div $input 4 -}}
{{- end -}}
{{- end -}}

{{/*
Calcuate the direct memory used by Dremio
*/}}
{{- define "DirectMemory" -}}
{{- $input := int . -}}
{{- if ge $input 32768 -}}
{{ sub $input 8192 }}
{{- else if ge $input 16384 -}}
{{ sub $input 4096 }}
{{- else if ge $input 4096 -}}
{{ sub $input 2048 }}
{{- else -}}
{{- $t1 := div $input 4 -}}
{{- sub $input $t1 -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified coordinator name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "dremio.coordinator.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.coordinator.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.coordinator.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified executor name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "dremio.executor.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.executor.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.executor.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified master name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "dremio.master.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.master.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.master.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Create a default fully qualified zookeeper name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "dremio.zk.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.zookeeper.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.zookeeper.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Create a zookeeper endpoint.  Allows for "bring your own zookeeper"
*/}}
{{- define "dremio.zk.service" -}}
{{ template "dremio.zk.fullname" . }}
{{- end -}}

{{/*
Create a zookeeper endpoint.  Allows for "bring your own zookeeper"
*/}}
{{- define "dremio.zk.endpoint" -}}
{{ template "dremio.zk.service" . }}:{{ .Values.zookeeper.client_port }}
{{- end -}}


{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "dremio.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
