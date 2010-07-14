#include <iostream>
#include <OpenGL/OpenGL.h>
#include <GLUT/GLUT.h>
#include <stdlib.h>
#include <stdio.h>
#include <math.h>

void display() 
{
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	
	glLoadIdentity();
	
	//particleSystem->Update(0);
	//particleSystem->Render();
	
	glutSwapBuffers();
}

void reshape(int width, int height)
{
	glViewport(0, 0, width, height);
}

void idle()
{
	glutPostRedisplay();
}

int main (int argc, char ** argv) {
	
	srand(time(0));
    
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE | GLUT_DEPTH);
	glutInitWindowSize(640, 480);
	glutCreateWindow("Particles");
	
	glutDisplayFunc(display);
	glutReshapeFunc(reshape);
	glutIdleFunc(idle);
	glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
	glClearColor(0.0, 0.0, 1.0, 0);
	glClearDepth(1.0);
	glDepthFunc(GL_LEQUAL);
	glEnable(GL_DEPTH_TEST);
	glShadeModel(GL_SMOOTH);
	
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluPerspective(45.0, 640 / 480, 0.1, 100.0);
	
	glMatrixMode(GL_MODELVIEW);
	
	std::cout << rand() /(float)10000000000.0f << std::endl;
	
	glutMainLoop();
	
	return EXIT_SUCCESS;
}
