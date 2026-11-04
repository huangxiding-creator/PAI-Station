.class public final synthetic Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Lcom/alibaba/sdk/android/oss/callback/OSSProgressCallback;


# instance fields
.field public final synthetic f$0:J

.field public final synthetic f$1:Lkotlin/jvm/functions/Function1;


# direct methods
.method public synthetic constructor <init>(JLkotlin/jvm/functions/Function1;)V
    .locals 0

    .line 0
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-wide p1, p0, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2$$ExternalSyntheticLambda0;->f$0:J

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2$$ExternalSyntheticLambda0;->f$1:Lkotlin/jvm/functions/Function1;

    return-void
.end method


# virtual methods
.method public final onProgress(Ljava/lang/Object;JJ)V
    .locals 8

    .line 0
    iget-wide v0, p0, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2$$ExternalSyntheticLambda0;->f$0:J

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2$$ExternalSyntheticLambda0;->f$1:Lkotlin/jvm/functions/Function1;

    move-object v3, p1

    check-cast v3, Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;

    move-wide v4, p2

    move-wide v6, p4

    invoke-static/range {v0 .. v7}, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->$r8$lambda$k-XGbA0PKuVRISvp-b3zOKj7Fkk(JLkotlin/jvm/functions/Function1;Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;JJ)V

    return-void
.end method
