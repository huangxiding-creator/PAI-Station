.class public final Lcom/google/barhopper/deeplearning/zzn;
.super Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeh;
.source "com.google.mlkit:barcode-scanning@@17.3.0"

# interfaces
.implements Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzfn;


# static fields
.field private static final zzb:Lcom/google/barhopper/deeplearning/zzn;


# instance fields
.field private zzd:I

.field private zze:Ljava/lang/Object;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 1
    new-instance v0, Lcom/google/barhopper/deeplearning/zzn;

    invoke-direct {v0}, Lcom/google/barhopper/deeplearning/zzn;-><init>()V

    sput-object v0, Lcom/google/barhopper/deeplearning/zzn;->zzb:Lcom/google/barhopper/deeplearning/zzn;

    const-class v1, Lcom/google/barhopper/deeplearning/zzn;

    invoke-static {v1, v0}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeh;->zzV(Ljava/lang/Class;Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeh;)V

    return-void
.end method

.method private constructor <init>()V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzeh;-><init>()V

    const/4 v0, 0x0

    iput v0, p0, Lcom/google/barhopper/deeplearning/zzn;->zzd:I

    return-void
.end method

.method static synthetic zza()Lcom/google/barhopper/deeplearning/zzn;
    .locals 1

    sget-object v0, Lcom/google/barhopper/deeplearning/zzn;->zzb:Lcom/google/barhopper/deeplearning/zzn;

    return-object v0
.end method


# virtual methods
.method protected final zzg(ILjava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 2

    .line 2
    add-int/lit8 p1, p1, -0x1

    const/4 p2, 0x0

    packed-switch p1, :pswitch_data_0

    :pswitch_0
    return-object p2

    .line 1
    :pswitch_1
    sget-object p1, Lcom/google/barhopper/deeplearning/zzn;->zzb:Lcom/google/barhopper/deeplearning/zzn;

    return-object p1

    :pswitch_2
    new-instance p1, Lcom/google/barhopper/deeplearning/zzm;

    .line 3
    invoke-direct {p1, p2}, Lcom/google/barhopper/deeplearning/zzm;-><init>(Lcom/google/barhopper/deeplearning/zzl;)V

    return-object p1

    :pswitch_3
    new-instance p1, Lcom/google/barhopper/deeplearning/zzn;

    invoke-direct {p1}, Lcom/google/barhopper/deeplearning/zzn;-><init>()V

    return-object p1

    .line 2
    :pswitch_4
    const-class p1, Lcom/google/barhopper/deeplearning/zzt;

    const-class p2, Lcom/google/barhopper/deeplearning/zzz;

    const-class p3, Lcom/google/barhopper/deeplearning/zzw;

    const-string v0, "zze"

    const-string v1, "zzd"

    filled-new-array {v0, v1, p1, p2, p3}, [Ljava/lang/Object;

    move-result-object p1

    sget-object p2, Lcom/google/barhopper/deeplearning/zzn;->zzb:Lcom/google/barhopper/deeplearning/zzn;

    const-string p3, "\u0001\u0003\u0001\u0000\u0001\u0003\u0003\u0000\u0000\u0000\u0001<\u0000\u0002<\u0000\u0003<\u0000"

    invoke-static {p2, p3, p1}, Lcom/google/barhopper/deeplearning/zzn;->zzS(Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzfm;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    return-object p1

    .line 1
    :pswitch_5
    const/4 p1, 0x1

    invoke-static {p1}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object p1

    return-object p1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_5
        :pswitch_0
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method
