.class public final Lcom/google/android/gms/internal/mlkit_vision_barcode/zzar;
.super Ljava/lang/Object;
.source "com.google.android.gms:play-services-mlkit-barcode-scanning@@18.3.1"


# static fields
.field private static final zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzbb;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 1
    :try_start_0
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtimeNanos()J

    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzap;

    invoke-direct {v0}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzap;-><init>()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    .line 2
    :catchall_0
    move-exception v0

    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzaq;

    invoke-direct {v0}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzaq;-><init>()V

    .line 1
    :goto_0
    sput-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzar;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzbb;

    return-void
.end method

.method public static zza()Lcom/google/android/gms/internal/mlkit_vision_barcode/zzbb;
    .locals 1

    sget-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzar;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzbb;

    return-object v0
.end method
