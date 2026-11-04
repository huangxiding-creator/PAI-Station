.class public final Lcom/google/android/odml/image/MlImage$Internal;
.super Ljava/lang/Object;
.source "com.google.android.odml:image@@1.0.0-beta1"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/google/android/odml/image/MlImage;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Internal"
.end annotation


# instance fields
.field private final zza:Lcom/google/android/odml/image/MlImage;


# direct methods
.method synthetic constructor <init>(Lcom/google/android/odml/image/MlImage;Lcom/google/android/odml/image/zzj;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/google/android/odml/image/MlImage$Internal;->zza:Lcom/google/android/odml/image/MlImage;

    return-void
.end method


# virtual methods
.method public acquire()V
    .locals 1

    .end local p0    # "this":Lcom/google/android/odml/image/MlImage$Internal;
    iget-object v0, p0, Lcom/google/android/odml/image/MlImage$Internal;->zza:Lcom/google/android/odml/image/MlImage;

    .line 1
    invoke-static {v0}, Lcom/google/android/odml/image/MlImage;->zzb(Lcom/google/android/odml/image/MlImage;)V

    return-void
.end method
