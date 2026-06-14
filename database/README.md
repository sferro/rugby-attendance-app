# Database

Fuente oficial actual del modelo de datos:

- rugby-attendance.sql

Este archivo contiene:
- Schema
- Índices
- Datos cargados para pruebas
- Datos M13 2026

Los archivos dentro de `archive/` son scripts intermedios usados durante la etapa de diseño del modelo. No deben usarse como fuente principal.

Para reconstruir la base:

cat database/rugby-attendance.sql | docker compose exec -T db psql -U rugby_user -d rugby_attendance_db
