const express = require("express");
const UserController = require("../controller/user.controller");
const router = express.Router();

router.post("/create", UserController.createUser); // full route /api/user/create*

router.put("/:id", UserController.updateUser); // Update user

router.delete("/:id", UserController.deleteUser); // Delete user

router.get("/:id", UserController.getUser); // Get user by ID

module.exports = router;
