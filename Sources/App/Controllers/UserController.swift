import Vapor

final class UserController {

    // view with users
    func list(_ req: Request) throws -> Future<[User]> {
        return User.query(on: req).all()
//        return User.query(on: req).all().flatMap { users in
//            let data = ["userlist": users]
//            return try req.view().render("userview", data)
//        }
    }

    // create a new user
    func create(_ req: Request) throws -> Future<User> {
        return try req.content.decode(User.self).flatMap {
            user in
            return user.save(on: req)
        }
//        return try req.content.decode(User.self).flatMap { user in
//            return user.save(on: req).map { _ in
//                return req.redirect(to: "users")
//            }
//        }
    }
    func update(_ req: Request) throws -> Future<User> {
        return try req.parameters.next(User.self).flatMap {
            user in
            return try req.content.decode(User.self).flatMap {
            newUser in
            user.username = newUser.username
            return user.save(on: req)
            }
        }
    }
}
