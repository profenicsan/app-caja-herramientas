import { Test, TestingModule } from '@nestjs/testing';
import { ProductoresController } from './productores.controller';
import { ProductoresService } from './productores.service';

describe('ProductoresController', () => {
  let controller: ProductoresController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [ProductoresController],
      providers: [ProductoresService],
    }).compile();

    controller = module.get<ProductoresController>(ProductoresController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
