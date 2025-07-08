
import { signToken } from "./jwt";
import { PrismaClient } from "@prisma/client";
import bcrypt from 'bcrypt';
// Importa el cliente de Prisma y bcrypt para manejar la autenticación

const prisma = new PrismaClient();

export const loginAuth = async (correo: string, password: string): Promise<string> => {
  console.log('auth.service::loginAuth');

  // 1. Buscar usuario por correo
  const user = await prisma.user.findUnique({ where: { correo } });
  if (!user) {
    throw new Error('Credenciales inválidas');
  }

  // 2. Verificar contraseña
  const valid = await bcrypt.compare(password, user.password);
  if (!valid) {
    throw new Error('Credenciales inválidas');
  }

  // 3. Firmar y devolver el token
  // Puedes incluir más claims en el payload según necesites
  const token = signToken({ id: user.id, correo: user.correo });
  return token;
};

export const signup = async (nombre: string, correo: string, password: string) => {
  const existingUser = await prisma.user.findUnique({ where: { correo } });
  if (existingUser) {
    throw new Error('El correo ya está registrado');
  }

  const hashedPassword = await bcrypt.hash(password, 10);

  const newUser = await prisma.user.create({
    data: {
      nombre,
      correo,
      password: hashedPassword,
    },
  });

  const token = signToken({ id: newUser.id, correo: newUser.correo });

  return {
    id: newUser.id,
    nombre: newUser.nombre,
    correo: newUser.correo,
    token,
  };
};
