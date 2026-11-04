.class public Lcom/google/mlkit/vision/barcode/bundled/internal/ThickBarcodeScannerCreator;
.super Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzbp;
.source "com.google.mlkit:barcode-scanning@@17.3.0"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 1
    nop

    .end local p0    # "this":Lcom/google/mlkit/vision/barcode/bundled/internal/ThickBarcodeScannerCreator;
    invoke-direct {p0}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzbp;-><init>()V

    return-void
.end method


# virtual methods
.method public newBarcodeScanner(Lcom/google/android/gms/dynamic/IObjectWrapper;Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzba;)Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzbn;
    .locals 1
    .param p1, "contextWrapper"    # Lcom/google/android/gms/dynamic/IObjectWrapper;
    .param p2, "options"    # Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzba;

    .line 1
    new-instance v0, Lcom/google/mlkit/vision/barcode/bundled/internal/zza;

    .end local p1    # "contextWrapper":Lcom/google/android/gms/dynamic/IObjectWrapper;
    .end local p2    # "options":Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzba;
    invoke-static {p1}, Lcom/google/android/gms/dynamic/ObjectWrapper;->unwrap(Lcom/google/android/gms/dynamic/IObjectWrapper;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/content/Context;

    invoke-direct {v0, p1, p2}, Lcom/google/mlkit/vision/barcode/bundled/internal/zza;-><init>(Landroid/content/Context;Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzba;)V

    return-object v0
.end method
