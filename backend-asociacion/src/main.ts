import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import {ValidationPipe} from "@nestjs/common";
import {SwaggerModule, DocumentBuilder} from "@nestjs/swagger";

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  app.enableCors();
  app.useGlobalPipes(new ValidationPipe());

  //Configuracion portada y Metadatos de API
  const config = new DocumentBuilder()
    .setTitle('API Caja de Herramientas Gestión Agrícola y Tributaria')
    .setDescription('Documentación de los endpoints para la plataforma')
    .setVersion('1.0')
    .addTag('productores')
    .build();

  //Construcción e inicio de interfaz Swagger
  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api/docs', app, document);

  await app.listen(3000);
}
bootstrap();
