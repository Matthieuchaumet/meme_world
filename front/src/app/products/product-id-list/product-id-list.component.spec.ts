import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ProductIdListComponent } from './product-id-list.component';

describe('ProductIdListComponent', () => {
  let component: ProductIdListComponent;
  let fixture: ComponentFixture<ProductIdListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ProductIdListComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ProductIdListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
