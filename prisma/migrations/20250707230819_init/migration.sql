-- CreateTable
CREATE TABLE "usuarios" (
    "id" SERIAL NOT NULL,
    "correo" VARCHAR(100) NOT NULL,
    "password" VARCHAR(255) NOT NULL,
    "nombre" VARCHAR(100),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "usuarios_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "citas" (
    "id_cita" SERIAL NOT NULL,
    "id_paciente" INTEGER NOT NULL,
    "id_medico" INTEGER NOT NULL,
    "fecha" DATE NOT NULL,
    "hora" TIME(6) NOT NULL,
    "estado_cita" CHAR(1) DEFAULT 'P',
    "estado_auditoria" CHAR(1) DEFAULT '1',
    "fecha_creacion" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "fecha_actualizacion" TIMESTAMP(6),

    CONSTRAINT "citas_pkey" PRIMARY KEY ("id_cita")
);

-- CreateTable
CREATE TABLE "especialidades" (
    "id_especialidad" SERIAL NOT NULL,
    "nombre" VARCHAR(100) NOT NULL,
    "estado_auditoria" CHAR(1) DEFAULT '1',
    "fecha_creacion" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "fecha_actualizacion" TIMESTAMP(6),

    CONSTRAINT "especialidades_pkey" PRIMARY KEY ("id_especialidad")
);

-- CreateTable
CREATE TABLE "horarios" (
    "id_horario" SERIAL NOT NULL,
    "id_medico" INTEGER NOT NULL,
    "dia_semana" CHAR(1) NOT NULL,
    "hora_inicio" TIME(6) NOT NULL,
    "hora_fin" TIME(6) NOT NULL,
    "estado_auditoria" CHAR(1) DEFAULT '1',
    "fecha_creacion" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "fecha_actualizacion" TIMESTAMP(6),

    CONSTRAINT "horarios_pkey" PRIMARY KEY ("id_horario")
);

-- CreateTable
CREATE TABLE "medicos" (
    "id_medico" SERIAL NOT NULL,
    "nombres" VARCHAR(100) NOT NULL,
    "apellidos" VARCHAR(100) NOT NULL,
    "correo" VARCHAR(100),
    "celular" VARCHAR(20),
    "id_especialidad" INTEGER NOT NULL,
    "estado_auditoria" CHAR(1) DEFAULT '1',
    "fecha_creacion" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "fecha_actualizacion" TIMESTAMP(6),

    CONSTRAINT "medicos_pkey" PRIMARY KEY ("id_medico")
);

-- CreateTable
CREATE TABLE "pacientes" (
    "id_paciente" SERIAL NOT NULL,
    "nombres" VARCHAR(120) NOT NULL,
    "apellidos" VARCHAR(100) NOT NULL,
    "edad" INTEGER,
    "fecha_nacimiento" DATE,
    "id_tipo_documento" INTEGER NOT NULL,
    "numero_documento" VARCHAR(20) NOT NULL,
    "direccion" TEXT,
    "correo" VARCHAR(100),
    "genero" CHAR(1) NOT NULL,
    "estado_auditoria" CHAR(1) DEFAULT '1',
    "fecha_creacion" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "fecha_actualizacion" TIMESTAMP(6),

    CONSTRAINT "pacientes_pkey" PRIMARY KEY ("id_paciente")
);

-- CreateTable
CREATE TABLE "tipo_documentos" (
    "id_tipo_documento" SERIAL NOT NULL,
    "nombre" VARCHAR(50) NOT NULL,
    "estado_auditoria" CHAR(1) DEFAULT '1',
    "fecha_creacion" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "fecha_actualizacion" TIMESTAMP(6),

    CONSTRAINT "tipo_documentos_pkey" PRIMARY KEY ("id_tipo_documento")
);

-- CreateIndex
CREATE UNIQUE INDEX "usuarios_correo_key" ON "usuarios"("correo");

-- CreateIndex
CREATE UNIQUE INDEX "especialidades_nombre_key" ON "especialidades"("nombre");

-- CreateIndex
CREATE UNIQUE INDEX "pacientes_numero_documento_key" ON "pacientes"("numero_documento");

-- CreateIndex
CREATE UNIQUE INDEX "tipo_documentos_nombre_key" ON "tipo_documentos"("nombre");

-- AddForeignKey
ALTER TABLE "citas" ADD CONSTRAINT "citas_id_medico_fkey" FOREIGN KEY ("id_medico") REFERENCES "medicos"("id_medico") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "citas" ADD CONSTRAINT "citas_id_paciente_fkey" FOREIGN KEY ("id_paciente") REFERENCES "pacientes"("id_paciente") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "horarios" ADD CONSTRAINT "horarios_id_medico_fkey" FOREIGN KEY ("id_medico") REFERENCES "medicos"("id_medico") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "medicos" ADD CONSTRAINT "medicos_id_especialidad_fkey" FOREIGN KEY ("id_especialidad") REFERENCES "especialidades"("id_especialidad") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "pacientes" ADD CONSTRAINT "pacientes_id_tipo_documento_fkey" FOREIGN KEY ("id_tipo_documento") REFERENCES "tipo_documentos"("id_tipo_documento") ON DELETE NO ACTION ON UPDATE NO ACTION;
