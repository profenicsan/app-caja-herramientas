import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ProductoresService } from './productores.service';
import { ProductoresController } from './productores.controller';
import { Productor } from './entities/productores.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Productor])], // ¡No olvides esta línea!
  controllers: [ProductoresController],
  providers: [ProductoresService],
})
export class ProductoresModule {}