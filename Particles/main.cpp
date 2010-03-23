#include <iostream>
#include <OpenGL/OpenGL.h>
#include <GLUT/GLUT.h>
#include <stdlib.h>
#include <stdio.h>
#include <math.h>

class Vector 
{
	
public:
	
	Vector()
	: x_(0), y_(0), z_(0) 
	{
		
	}
	
	Vector(float x, float y, float z)
		: x_(x), y_(y), z_(z) 
	{
		
	}
	
	void RenderVertex()
	{
		glTranslatef(x_, y_, z_);
	}
	
	float Length()
	{
		return sqrt(
					(x_ * x_) +
					(y_ * y_) +
					(z_ * z_)
					);
	}
	
	Vector Normalize()
	{
		float length = this->Length();		
		return Vector(x_ / length, y_ / length, z_ / length);
	}
	
	float operator * (const Vector &other) const
	{
		return (x_ * other.x_)  + (y_ * other.y_) + (z_ * other.z_);
	}
	
	Vector operator * (const float& other) const
	{
		return Vector(x_ * other, y_ * other, z_ * other);
	}
	
	Vector CrossProduct( const Vector& input ) const
	{
		Vector result = Vector(
						   y_ * input.z_ - z_ * input.y_,
						   z_ * input.x_ - x_ * input.z_,
						   x_ * input.y_ - y_ * input.x_
						   );
		
		return result;
	}
	
	bool ZIsPositive() { return z_ > 0; }
	
	Vector operator + (const Vector &other) const
	{
		return Vector(
					  x_ + other.x_,
					  y_ + other.y_,
					  z_ + other.z_
					  );
	}
	
	Vector operator += (const Vector &other) const
	{
		return *this + other;
	}
	
protected:
	
	float x_;
	float y_;
	float z_;
	
private:
	
	//Vector(const Vector& other) { }
	//Vector&  operator = (const Vector& other) { return *this; }
	
};

class Color
{

public:
	
	Color(float r, float g, float b)
		: r_(r)
		, g_(g)
		, b_(b)
	{
		
	}
	
	void RenderColor()
	{
		glColor3f(r_, g_, b_);
	}
	
private:
	
	float r_;
	float g_;
	float b_;
	
};

class Quaternion
{
	
public:
	
	Quaternion()
		: a_(0)
		, x_(0)
		, y_(0)
		, z_(0)
		{
			
		}
	
	Quaternion(float a, float x, float y, float z)
		: a_(a)
		, x_(x)
		, y_(y)
		, z_(z)
	{
		
	}
	
	void RenderOrientation()
	{
		glRotatef(a_, x_, y_, -1);
	}
	
	void SetAngle(float angleDegrees)
	{
		a_ = angleDegrees;
	}
	
	float a_;
	float x_;
	float y_;
	float z_;
	
};

template<class T>
T clamp(T X, T Min, T Max)
{
	if( X > Max )
		X = Max;
	else if( X < Min )
		X = Min;
	
	return X;
}

class Particle
{
	
public:
	
	~Particle() { };
	
	Particle() 
		: decay_(0.001f)
		, lifetime_(rand()/(float)RAND_MAX)
		, color_(new Color(rand()/(float)RAND_MAX, rand()/(float)RAND_MAX, rand()/(float)RAND_MAX))
	{
		
	}
	
	virtual void Update(float delta)
	{
		position_ = position_ + speed_;	
		
		Vector v1 = Vector(0.0f, 1.0f, 0.0f).Normalize();
		Vector v2 = speed_.Normalize();
		
		float dotProduct = clamp(v1 * v2, -1.0f, 1.0f);
		float angleRadians = acos(dotProduct);
		
		Vector cross = v1.CrossProduct(v2);
		
		if(cross.ZIsPositive())
		{
			angleRadians *= -1.0f;
		}
		
		float angleDegrees = angleRadians * (180.0f / M_PI);
		
		rotation_.SetAngle(angleDegrees);
		
		lifetime_ -= decay_;
	};
	
	void Render()
	{		
		glLoadIdentity();
		color_->RenderColor();
		
		glTranslatef(0.0f, 0.0f, -1.0f);
		position_.RenderVertex();
		rotation_.RenderOrientation();
		
		glBegin(GL_TRIANGLE_STRIP);
		glVertex3f( 0.001f,  0.01f, 0.0f); // top right
		glVertex3f(-0.001f,	 0.01f, 0.0f); // top left
		glVertex3f( 0.001f, -0.01f, 0.0f); // bottom right
		glVertex3f(-0.001f, -0.01f, 0.0f); // bottom left
		glEnd();
	};
	
	bool IsActive()
	{
		return lifetime_ > 0;
	};
	
protected:
	
	Vector position_;
	Quaternion rotation_;
	Vector speed_;
	Color* color_;
	bool isActive_;
	float decay_;
	float lifetime_;
};

class FountainParticle : public Particle {
	
public:
	
	FountainParticle()
		: Particle()
	{
		speed_ = Vector(0.001f - rand() /(float)1000000000000.0f, 0.001f, 0.0f);
	}
	
	void Update(float delta)
	{
		Particle::Update(delta);
		
		speed_ = speed_ + Vector(0.0f, -0.000005f, 0.0f);
	}
	
};

class ExplosionParticle : public Particle {
	
public:
	
	ExplosionParticle()
		: Particle()
	{
		decay_ = 0.001f;
		float explosionModifier = 0.001f;
		float explosionVelocity = 1000000000000.0f;
		
		float xSpeed = explosionModifier - rand() /(float)explosionVelocity;
		float ySpeed = explosionModifier - rand() /(float)explosionVelocity;
		
		speed_ = Vector(xSpeed, ySpeed, 0.0f);
	}
	
};

class ParticleSystem
{
	
	static const int MAX_PARTICLES = 1000;
	
public:
	
	~ParticleSystem() { };
	
	ParticleSystem() { };
	
	Particle* CreateParticle()
	{
		return new FountainParticle();
	}
	
	void Setup()
	{
		for (int i = 0; i < MAX_PARTICLES; i++) {
			particles[i] = CreateParticle();
		}
	}
	
	void Teardown()
	{
		for (int i = 0; i < MAX_PARTICLES; i++) {
			delete particles[i];
		}
	}
	
	void Update(float delta)
	{		
		for (int i = 0; i < MAX_PARTICLES; i++) {
			if (!particles[i]->IsActive()) {
				delete particles[i];
				particles[i] = CreateParticle();
			}
			particles[i]->Update(delta);
		}
	};
	
	void Render()
	{
		for (int i = 0; i < MAX_PARTICLES; i++) {
			particles[i]->Render();
		}
	};
	
private:
	
	Particle* particles[MAX_PARTICLES];
};

ParticleSystem* particleSystem;

void display() 
{
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
	
	glLoadIdentity();
	
	particleSystem->Update(0);
	particleSystem->Render();
	
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
	
	particleSystem = new ParticleSystem();
	particleSystem->Setup();
	
	glutMainLoop();
	
	particleSystem->Teardown();
	
	return EXIT_SUCCESS;
}
