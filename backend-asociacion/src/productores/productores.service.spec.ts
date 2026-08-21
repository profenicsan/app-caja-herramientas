import { Test, TestingModule } from '@nestjs/testing';
import { ProductoresService } from './productores.service';

describe('ProductoresService', () => {
  let service: ProductoresService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [ProductoresService],
    }).compile();

    service = module.get<ProductoresService>(ProductoresService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
