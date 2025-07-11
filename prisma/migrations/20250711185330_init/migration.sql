-- CreateTable
CREATE TABLE "Admin" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "email" TEXT NOT NULL,
    "senha" TEXT NOT NULL,

    CONSTRAINT "Admin_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "casas" (
    "id" SERIAL NOT NULL,
    "endereco" TEXT NOT NULL,
    "numero" INTEGER NOT NULL,
    "cep" TEXT,
    "cidade" TEXT,
    "estado" TEXT,
    "diretrizes" TEXT NOT NULL,
    "complemento" TEXT,
    "precoPorNoite" DOUBLE PRECISION,
    "locadorId" INTEGER NOT NULL,

    CONSTRAINT "casas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "imagens_casa" (
    "id" SERIAL NOT NULL,
    "url" TEXT NOT NULL,
    "casaId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "imagens_casa_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "bloqueios_disponibilidade" (
    "id" SERIAL NOT NULL,
    "dataInicio" TIMESTAMP(3) NOT NULL,
    "dataFim" TIMESTAMP(3) NOT NULL,
    "motivo" TEXT,
    "casaId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "bloqueios_disponibilidade_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "locadores" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "senha" TEXT NOT NULL,
    "cpf" TEXT NOT NULL,
    "endereco" TEXT NOT NULL,
    "cep" TEXT,
    "cidade" TEXT,
    "estado" TEXT,

    CONSTRAINT "locadores_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Hospede" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "senha" TEXT NOT NULL,
    "cpf" TEXT NOT NULL,
    "cep" TEXT,
    "cidade" TEXT,
    "estado" TEXT,
    "matricula" TEXT NOT NULL,
    "universidade" TEXT,

    CONSTRAINT "Hospede_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "reservas" (
    "id" SERIAL NOT NULL,
    "dataCheckIn" TIMESTAMP(3) NOT NULL,
    "dataCheckOut" TIMESTAMP(3) NOT NULL,
    "status" TEXT NOT NULL,
    "numeroHospedes" INTEGER,
    "valorTotal" DOUBLE PRECISION,
    "observacoes" TEXT,
    "valorTotalCalculado" DOUBLE PRECISION,
    "statusPagamento" TEXT,
    "hospedeId" INTEGER NOT NULL,
    "casaId" INTEGER NOT NULL,
    "locadorId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "reservas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "favoritos" (
    "id" SERIAL NOT NULL,
    "hospedeId" INTEGER NOT NULL,
    "casaId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "favoritos_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "conversas" (
    "id" SERIAL NOT NULL,
    "hospedeId" INTEGER NOT NULL,
    "locadorId" INTEGER NOT NULL,
    "casaId" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "conversas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "mensagens" (
    "id" SERIAL NOT NULL,
    "conteudo" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "conversaId" INTEGER NOT NULL,
    "remetenteHospedeId" INTEGER,
    "remetenteLocadorId" INTEGER,
    "lidaPeloHospede" BOOLEAN NOT NULL DEFAULT false,
    "lidaPeloLocador" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "mensagens_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "avaliacoes" (
    "id" SERIAL NOT NULL,
    "nota" INTEGER NOT NULL,
    "comentario" TEXT,
    "reservaId" INTEGER NOT NULL,
    "hospedeId" INTEGER NOT NULL,
    "casaId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "avaliacoes_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Admin_email_key" ON "Admin"("email");

-- CreateIndex
CREATE UNIQUE INDEX "locadores_email_key" ON "locadores"("email");

-- CreateIndex
CREATE UNIQUE INDEX "locadores_cpf_key" ON "locadores"("cpf");

-- CreateIndex
CREATE UNIQUE INDEX "Hospede_email_key" ON "Hospede"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Hospede_cpf_key" ON "Hospede"("cpf");

-- CreateIndex
CREATE UNIQUE INDEX "Hospede_matricula_key" ON "Hospede"("matricula");

-- CreateIndex
CREATE UNIQUE INDEX "favoritos_hospedeId_casaId_key" ON "favoritos"("hospedeId", "casaId");

-- CreateIndex
CREATE UNIQUE INDEX "conversas_hospedeId_locadorId_casaId_key" ON "conversas"("hospedeId", "locadorId", "casaId");

-- CreateIndex
CREATE UNIQUE INDEX "avaliacoes_reservaId_key" ON "avaliacoes"("reservaId");

-- AddForeignKey
ALTER TABLE "casas" ADD CONSTRAINT "casas_locadorId_fkey" FOREIGN KEY ("locadorId") REFERENCES "locadores"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "imagens_casa" ADD CONSTRAINT "imagens_casa_casaId_fkey" FOREIGN KEY ("casaId") REFERENCES "casas"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bloqueios_disponibilidade" ADD CONSTRAINT "bloqueios_disponibilidade_casaId_fkey" FOREIGN KEY ("casaId") REFERENCES "casas"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reservas" ADD CONSTRAINT "reservas_hospedeId_fkey" FOREIGN KEY ("hospedeId") REFERENCES "Hospede"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reservas" ADD CONSTRAINT "reservas_casaId_fkey" FOREIGN KEY ("casaId") REFERENCES "casas"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reservas" ADD CONSTRAINT "reservas_locadorId_fkey" FOREIGN KEY ("locadorId") REFERENCES "locadores"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "favoritos" ADD CONSTRAINT "favoritos_hospedeId_fkey" FOREIGN KEY ("hospedeId") REFERENCES "Hospede"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "favoritos" ADD CONSTRAINT "favoritos_casaId_fkey" FOREIGN KEY ("casaId") REFERENCES "casas"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "conversas" ADD CONSTRAINT "conversas_hospedeId_fkey" FOREIGN KEY ("hospedeId") REFERENCES "Hospede"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "conversas" ADD CONSTRAINT "conversas_locadorId_fkey" FOREIGN KEY ("locadorId") REFERENCES "locadores"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "conversas" ADD CONSTRAINT "conversas_casaId_fkey" FOREIGN KEY ("casaId") REFERENCES "casas"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "mensagens" ADD CONSTRAINT "mensagens_conversaId_fkey" FOREIGN KEY ("conversaId") REFERENCES "conversas"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "mensagens" ADD CONSTRAINT "mensagens_remetenteHospedeId_fkey" FOREIGN KEY ("remetenteHospedeId") REFERENCES "Hospede"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "mensagens" ADD CONSTRAINT "mensagens_remetenteLocadorId_fkey" FOREIGN KEY ("remetenteLocadorId") REFERENCES "locadores"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "avaliacoes" ADD CONSTRAINT "avaliacoes_reservaId_fkey" FOREIGN KEY ("reservaId") REFERENCES "reservas"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "avaliacoes" ADD CONSTRAINT "avaliacoes_hospedeId_fkey" FOREIGN KEY ("hospedeId") REFERENCES "Hospede"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "avaliacoes" ADD CONSTRAINT "avaliacoes_casaId_fkey" FOREIGN KEY ("casaId") REFERENCES "casas"("id") ON DELETE CASCADE ON UPDATE CASCADE;
