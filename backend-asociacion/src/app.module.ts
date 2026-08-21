import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ProductoresModule } from './productores/productores.module';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'postgres',
      host: 'localhost',
      port: 5432,
      username: 'admin_asociacion',
      password: 'Password123',
      database: 'db_asociacion',
      autoLoadEntities: true,
      synchronize: false,
    }),
    ProductoresModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}