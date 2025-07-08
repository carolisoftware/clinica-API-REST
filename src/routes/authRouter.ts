import { Router } from 'express';
import { signup, loginAuth } from '../auth/auth.controller';


const router: Router = Router();

// Ruta de registro (signup)
router.post('/signup', signup);

// Ruta de login (auth)
router.post('/login', loginAuth);

export default router;