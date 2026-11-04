.class public final Lcom/google/barhopper/deeplearning/zzh;
.super Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeb;
.source "com.google.mlkit:barcode-scanning@@17.3.0"

# interfaces
.implements Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzfn;


# direct methods
.method private constructor <init>()V
    .locals 1

    const/4 v0, 0x0

    throw v0
.end method

.method synthetic constructor <init>(Lcom/google/barhopper/deeplearning/zzg;)V
    .locals 0

    .line 1
    invoke-static {}, Lcom/google/barhopper/deeplearning/zzi;->zzb()Lcom/google/barhopper/deeplearning/zzi;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeb;-><init>(Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeh;)V

    return-void
.end method


# virtual methods
.method public final zza(Lcom/google/barhopper/deeplearning/zze;)Lcom/google/barhopper/deeplearning/zzh;
    .locals 1

    .line 1
    invoke-virtual {p0}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeb;->zzm()V

    iget-object v0, p0, Lcom/google/barhopper/deeplearning/zzh;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeh;

    .line 2
    check-cast v0, Lcom/google/barhopper/deeplearning/zzi;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeb;->zzh()Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeh;

    move-result-object p1

    check-cast p1, Lcom/google/barhopper/deeplearning/zzf;

    invoke-static {v0, p1}, Lcom/google/barhopper/deeplearning/zzi;->zzc(Lcom/google/barhopper/deeplearning/zzi;Lcom/google/barhopper/deeplearning/zzf;)V

    return-object p0
.end method

.method public final zzb(Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdf;)Lcom/google/barhopper/deeplearning/zzh;
    .locals 1

    .line 1
    invoke-virtual {p0}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeb;->zzm()V

    iget-object v0, p0, Lcom/google/barhopper/deeplearning/zzh;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeh;

    .line 2
    check-cast v0, Lcom/google/barhopper/deeplearning/zzi;

    invoke-static {v0, p1}, Lcom/google/barhopper/deeplearning/zzi;->zzd(Lcom/google/barhopper/deeplearning/zzi;Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzdf;)V

    return-object p0
.end method
