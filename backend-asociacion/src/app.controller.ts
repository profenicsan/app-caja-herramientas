import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';

//Ruta de la URL localhost:3000/productores
@Controller('productores')
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  obtenerTodos(){
    return this.appService.getProductores();
  }
}