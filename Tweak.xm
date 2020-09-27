#include "substrate.h"
#include <string>
#include <cstdio>
#include <mach-o/dyld.h>
#include <stdint.h>

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

struct LocalPlayer;

struct Vec3 {

	float x, y, z;
};

static uintptr_t** VTLocalPlayer;

static void(*_LocalPlayer$setPos)(LocalPlayer*, Vec3 const&);
static void LocalPlayer$setPos(LocalPlayer* player, Vec3 const& vec3) {

	_LocalPlayer$setPos(player, {vec3.x, 200.0f, vec3.z});
}

%ctor {
	//Ms.Marina Terry told me.
	//By hooking a function from vtable, we don't have to use MSHookFuntion!
	VTLocalPlayer = (uintptr_t**)(0x1033026d8 + _dyld_get_image_vmaddr_slide(0));

	_LocalPlayer$setPos = (void(*)(LocalPlayer*, Vec3 const&)) VTLocalPlayer[9];

	VTLocalPlayer[9] = (uintptr_t*)&LocalPlayer$setPos;
}