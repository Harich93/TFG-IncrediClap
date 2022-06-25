import { Router } from "express";
import { postAudio, getAllAudios, deleteAudio, getUserAudios, getAudio } from '../controllers/audio.controllers';
import validateJWT from "../middlewares/validate-jwt.middleware";
import validateFields from '../middlewares/validateFields.middleware';

const router = Router();

router.get("/all",getAllAudios);

router.get("/:id",getAudio);

router.get("/",[
   validateJWT,
   validateFields
], getUserAudios)

router.post("/add",
[
   validateJWT,
   validateFields
],postAudio)


router.delete("/:id",
[
   validateJWT,
   validateFields
],deleteAudio)

export default router;