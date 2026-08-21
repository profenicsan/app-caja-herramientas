import { Controller, Post, Body } from '@nestjs/common';
import { ProductoresService } from './productores.service';
import { CreateProductoresDto } from './dto/create-productores.dto';

@Controller('productores')
export class ProductoresController {
  constructor(private readonly productoresService: ProductoresService) {}

  @Post('pre-registro')
  async preRegistro(@Body() createProductoresDto: CreateProductoresDto) {
    return await this.productoresService.preRegistrar(createProductoresDto);
  }
}