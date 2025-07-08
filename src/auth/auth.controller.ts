import { Request, Response } from 'express';
import * as loginService from './auth.service';
import { ResponseModel } from '../shared/responseModel';
import { STATUS_UNAUTHORIZED, STATUS_BAD_REQUEST } from '../shared/constants';




export const loginAuth = async (req: Request, res: Response): Promise<any> => {
  const { correo, password } = req.body;

  if (!correo || !password) {
    return res
      .status(STATUS_BAD_REQUEST)
      .json(ResponseModel.error('Faltan campos: correo y/o contraseña'));
  }

  try {
    const token = await loginService.loginAuth(correo, password);
    return res.json(ResponseModel.success({ token }));
  } catch (error: any) {
    return res
      .status(STATUS_UNAUTHORIZED)
      .json(ResponseModel.error(error.message));
  }
};


// ✅ Nuevo controlador de registro
export const signup = async (req: Request, res: Response): Promise<any> => {
  const { nombre, correo, password } = req.body;

  if (!nombre || !correo || !password) {
    return res
      .status(STATUS_BAD_REQUEST)
      .json(ResponseModel.error('Faltan campos: nombre, correo y/o contraseña'));
  }

  try {
    const nuevoUsuario = await loginService.signup(nombre, correo, password);
    return res.status(201).json(ResponseModel.success(nuevoUsuario));
  } catch (error: any) {
    return res
      .status(STATUS_BAD_REQUEST)
      .json(ResponseModel.error(error.message));
  }
};
