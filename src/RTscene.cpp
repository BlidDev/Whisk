#include "RTscene.h"

RTScene::RTScene() : Scene("RT") { 
    close = false; 
    physics_tickrate = 50;
    display_quad = {};
}


void RTScene::on_create() {
    if (!file_path.empty() && uuids.empty()) 
        add_from_file(file_path);
    lua_action_init(this);
    actions_init(this);
    display_quad = get_mesh("DefaultDisplayQuad");
}

void RTScene::on_update(float dt) {
    close = is_key_pressed(GLFW_KEY_ESCAPE);
    actions_update(this,dt);
    lua_action_update(this, dt);

    if (fixed_physics(this, physics_tickrate, dt)) return;

    player = uuid_to_entity(main_camera);
    glm::vec2 view = manager->main_window.size();

    rescale_camera_to_window(player.get_component<CameraComp>(), manager->main_window);
    draw_to_camera(manager->render_data, view, player, registry, &s_render_data);
    present_camera(player, display_quad);
    glfwSwapBuffers(manager->main_window);
    glfwPollEvents();

}

void RTScene::on_end() {
  lua_action_end(this);
  actions_end(this);
  close = false;
}

bool RTScene::should_close() {
  return glfwWindowShouldClose(manager->main_window) || close;
}


