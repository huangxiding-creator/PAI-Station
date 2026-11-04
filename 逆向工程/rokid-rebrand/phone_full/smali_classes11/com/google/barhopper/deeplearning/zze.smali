.class public final Lcom/google/barhopper/deeplearning/zze;
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

.method synthetic constructor <init>(Lcom/google/barhopper/deeplearning/zzd;)V
    .locals 0

    .line 1
    invoke-static {}, Lcom/google/barhopper/deeplearning/zzf;->zzb()Lcom/google/barhopper/deeplearning/zzf;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeb;-><init>(Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeh;)V

    return-void
.end method


# virtual methods
.method public final zza(Lcom/google/barhopper/deeplearning/zzb;)Lcom/google/barhopper/deeplearning/zze;
    .locals 1

    .line 1
    invoke-virtual {p0}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeb;->zzm()V

    iget-object v0, p0, Lcom/google/barhopper/deeplearning/zze;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeh;

    .line 2
    check-cast v0, Lcom/google/barhopper/deeplearning/zzf;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeb;->zzh()Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeh;

    move-result-object p1

    check-cast p1, Lcom/google/barhopper/deeplearning/zzc;

    invoke-static {v0, p1}, Lcom/google/barhopper/deeplearning/zzf;->zzc(Lcom/google/barhopper/deeplearning/zzf;Lcom/google/barhopper/deeplearning/zzc;)V

    return-object p0
.end method
